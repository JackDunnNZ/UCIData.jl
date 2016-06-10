using ConfParser
using DataFrames

TOL = 1e-8

function numberstringtoint(s)
  if s == "one"
    1
  elseif s == "two"
    2
  elseif s == "three"
    3
  elseif s == "four"
    4
  elseif s == "five"
    5
  elseif s == "six"
    6
  elseif s == "seven"
    7
  elseif s == "eight"
    8
  elseif s == "nine"
    9
  elseif s == "ten"
    10
  elseif s == "eleven"
    11
  elseif s == "twelve"
    12
  else
    throw("unknown number")
  end
end

function confstringtoindices(s::AbstractString)
  [parse(Int, s)]
end

function confstringtoindices(s::Array)
  if isempty(s)
    Int[]
  else
    [parse(Int,x) for x in s]
  end
end

function makeid(df::DataFrame, i::Int, id_indices::Array{Int})
  if isempty(id_indices)
    id = "$i"
  else
    id = join([df[i, j] for j in id_indices], "_")
  end
  #return "id_$id"
end

function intorna(input::DataArray{Bool, 1})
  n = length(input)
  output = DataArray(Int, n)
  for i in 1:n
    value = input[i]
    output[i] = isna(value) ? NA : Int(value)
  end
  return output
end

function processdir(data_path::AbstractString, processed_path::AbstractString, normalize::Bool)
  config_path = ascii(joinpath(data_path, "config.ini"))
  if !isfile(config_path)
    return
  end

  # Read config file
  conf = ConfParse(config_path)
  parse_conf!(conf)

  name                 = retrieve(conf, "info", "name")
  data_url             = retrieve(conf, "info", "data_url")
  y_index              = retrieve(conf, "info", "y_index")
  id_indices           = retrieve(conf, "info", "id_indices")
  value_indices        = retrieve(conf, "info", "value_indices")
  categoric_indices    = retrieve(conf, "info", "categoric_indices")
  make_integer_indices = retrieve(conf, "info", "make_integer_indices")
  separator            = retrieve(conf, "info", "separator")
  header_lines         = retrieve(conf, "info", "header_lines")

  y_index = parse(Int, y_index)
  header_lines = parse(Int, header_lines)

  id_indices = confstringtoindices(id_indices)
  value_indices = confstringtoindices(value_indices)
  categoric_indices = confstringtoindices(categoric_indices)
  make_integer_indices = confstringtoindices(make_integer_indices)

  # Get char from string
  if separator == "comma"
    separator = ','
  else
    separator = isempty(separator) ? ' ' : separator[1]
  end

  name_orig = "$name.orig"
  dataset_path = joinpath(data_path, name_orig)

  if !isfile(dataset_path)
    download(data_url, dataset_path)
  end

  # Any time we need custom behavior, call the custom.jl file.
  # This is for when the UCI file is abnormal.
  custom_path = joinpath(data_path, "custom.jl")
  if isfile(custom_path)
    include(custom_path)
    dataset_path = "$dataset_path.custom"
  end

  df = readtable(
      dataset_path,
      header=false,
      separator=separator,
      nastrings=["", "NA", "?", "*", "#DIV/0!"],
      truestrings=["T", "t", "TRUE", "true", "y", "yes"],
      falsestrings=["F", "f", "FALSE", "false", "n", "no"],
      skipstart=header_lines
  )

  # Delete rows with NA values. This is needed by normalize
  for i in 1:size(df, 2)
    deleterows!(df,find(isna(df[:, i])))
  end
  num_rows = size(df, 1)

  if num_rows == 0
    return
  end

  output_df = DataFrame()
  output_df[:id] = [makeid(df, i, id_indices) for i in 1:size(df, 1)]

  # Construct output values
  index = 2
  for i in value_indices
    # Replace categoric variables with binaries
    if i in categoric_indices
      categories = levels(pool(df[i]))
      n = length(categories)
      for j in 2:n
        output_df[index] = intorna(df[i] .== categories[j])
        index += 1
      end
    elseif i in make_integer_indices
      output_df[index] = Int[numberstringtoint(x) for x in df[i]]
      index += 1
    else
      output_df[index] = df[i]
      index += 1
    end
  end

  if normalize
    mins = colwise(minimum, output_df[2:end])
    maxs = colwise(maximum, output_df[2:end])
    for j in 2:size(output_df, 2)
      new_col = PooledDataArray(Float64, num_rows)

      denom = maxs[j - 1][1] - mins[j - 1][1]
      # If max and min are the same, this column is all the same value
      # We can just set denom to 1 and everything comes out as zero
      if denom < TOL
        for i in 1:size(output_df, 1)
          new_col[i] = isna(output_df[i, j]) ? NA : 0
        end
      else
        for i in 1:size(output_df, 1)
          value = output_df[i, j] - mins[j - 1][1]
          value = value < TOL ? 0 : value
          new_col[i] = value / denom
        end
      end

      output_df[j] = new_col
    end
  end

  output_path = joinpath(processed_path, name)

  output_df[:class] = df[y_index]
  writetable(output_path, output_df, separator=',', header=false)
end

function processalldirs(normalize::Bool=false)
  root_path = dirname(@__FILE__)
  datafiles_path = joinpath(root_path, "datafiles")

  normalize_path = normalize ? "normalized" : "original"
  processed_path = joinpath(root_path, "processed", normalize_path)
  mkpath(processed_path)

  for dir in readdir(datafiles_path)
    data_path = joinpath(datafiles_path, dir)
    if !isdir(data_path)
      continue
    end
    println("Processing $dir")
    processdir(data_path, processed_path, normalize)
  end
end
