using ArgParse
using ConfParser
using DataFrames

TOL = 1e-8

function confStringToIndices(s::String)
  [int(s)]
end

function confStringToIndices(s::Array{String})
  if isempty(s)
    Int[]
  else
    map(int, s)
  end
end

function makeId(df::DataFrame, i::Int, id_indices::Array{Int})
  if isempty(id_indices)
    id = "$i"
  else
    id = join([df[i, j] for j in id_indices], "_")
  end
  #return "id_$id"
end

function intOrNA(input::DataArray{Bool, 1})
  n = length(input)
  output = DataArray(Int, n)
  for i in 1:n
    value = input[i]
    output[i] = isna(value) ? NA : int(value)
  end
  return output
end

function processDir(data_path::String, processed_path::String, normalize::Bool,
                    class_size::Int)
  config_path = joinpath(data_path, "config.ini")
  if !isfile(config_path)
    return
  end

  # Read config file
  conf = ConfParse(config_path)
  parse_conf!(conf)

  name              = retrieve(conf, "info", "name")
  data_url          = retrieve(conf, "info", "data_url")
  class_index       = retrieve(conf, "info", "class_index")
  id_indices        = retrieve(conf, "info", "id_indices")
  value_indices     = retrieve(conf, "info", "value_indices")
  categoric_indices = retrieve(conf, "info", "categoric_indices")
  separator         = retrieve(conf, "info", "separator")
  header_lines      = retrieve(conf, "info", "header_lines")

  class_index = int(class_index)
  header_lines = int(header_lines)

  id_indices = confStringToIndices(id_indices)
  value_indices = confStringToIndices(value_indices)
  categoric_indices = confStringToIndices(categoric_indices)

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
  output_df[:id] = [makeId(df, i, id_indices) for i in 1:size(df, 1)]

  # Construct output values
  index = 2
  for i in value_indices
    # Replace categoric variables with binaries
    if i in categoric_indices
      categories = levels(pool(df[i]))
      n = length(categories)
      for j in 2:n
        output_df[index] = intOrNA(df[i] .== categories[j])
        index += 1
      end
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

  if class_size == 0
    output_df[:class] = df[class_index]
    writetable(output_path, output_df, separator=',', header=false)
  else
    classes = levels(pool(df[class_index]))
    output_df[:class] = 0
    for comb in combinations(1:length(classes), class_size)
      output_rows = Int64[]
      for i in 1:class_size
        rows = df[class_index] .== classes[comb[i]]
        append!(output_rows, find(rows))
        output_df[rows, :class] = i - 1
      end
      writetable("$output_path.$(comb[1]).$(comb[2])",
                 output_df[output_rows, :], separator=',', header=false)
    end
  end
end

function processAllDirs(normalize::Bool=false, class_size::Int=0)
  root_path = dirname(@__FILE__)
  datafiles_path = joinpath(root_path, "datafiles")

  normalize_path = normalize ? "normalized" : "original"
  class_size_path = class_size > 0 ? "$class_size" : "all"
  processed_path = joinpath(root_path, "processed", normalize_path,
                            class_size_path)
  mkpath(processed_path)

  for dir in readdir(datafiles_path)
    data_path = joinpath(datafiles_path, dir)
    if !isdir(data_path)
      continue
    end
    println("Processing $dir")
    processDir(data_path, processed_path, normalize, class_size)
  end
end

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--normalize", "-n"
      help = "set if the data is to be normalized"
      action = :store_true
    "--class_size", "-c"
      help = "optional: the number of classes to use in output datasets. " *
             "Leave as zero to include all classes."
      arg_type = Int
      default = 0
  end
  parsed_args = parse_args(s)
  normalize = parsed_args["normalize"]
  class_size = parsed_args["class_size"]
  processAllDirs(normalize, class_size)
end

main()
