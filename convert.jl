using Combinatorics
using ConfParser
using DataFrames
using ZipFile

TOL = 1e-8

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

function processdir(data_path::String, processed_path::String,
                    problemtype::String, normalize::Bool, keepcat::Bool,
                    class_size::Int, min_size::Int)
  config_path = ascii(joinpath(data_path, "config.ini"))
  if !isfile(config_path)
    return
  end

  # Read config file
  conf = ConfParse(config_path)
  parse_conf!(conf)

  name              = retrieve(conf, "info", "name")
  data_url          = retrieve(conf, "info", "data_url")
  target_index      = retrieve(conf, "info", "target_index")
  id_indices        = retrieve(conf, "info", "id_indices")
  value_indices     = retrieve(conf, "info", "value_indices")
  categoric_indices = retrieve(conf, "info", "categoric_indices")
  separator         = retrieve(conf, "info", "separator")
  header_lines      = retrieve(conf, "info", "header_lines")

  target_index = parse(Int, target_index)
  header_lines = parse(Int, header_lines)

  id_indices = confstringtoindices(id_indices)
  value_indices = confstringtoindices(value_indices)
  categoric_indices = confstringtoindices(categoric_indices)

  # Get char from string
  if separator == "comma"
    separator = ','
  else
    separator = isempty(separator) ? ' ' : separator[1]
  end

  dataset_path = joinpath(data_path, "$name.orig")

  if !isfile(dataset_path)
    ext = splitext(data_url)[end]
    download_path = joinpath(data_path, "$name$ext")
    download(data_url, download_path)

    if ext == ".zip"
      unzipped_dir = ZipFile.Reader(download_path)
      for file in unzipped_dir.files
        if splitext(file.name)[end] in [".data", ".csv", ".txt"]
          write(dataset_path, readstring(file))
        end
      end
    elseif ext in [".tgz", ".gz"]
      contents_path = "$download_path-contents"
      isdir(contents_path) || mkdir(contents_path)
      run(`tar -xf $download_path -C $contents_path --strip-components=1`)

      for file in readdir(contents_path)
        if splitext(file)[end] in [".data", ".csv", ".txt"]
          write(dataset_path, readstring(joinpath(contents_path, file)))
        end
      end
    else
      !isfile(dataset_path) && mv(download_path, dataset_path)
    end
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
    if i in categoric_indices
      categories = levels(pool(df[i]))
      n = length(categories)
      # Keep categorical variables, map to C1, C2, etc.
      if keepcat
        mymap = Dict{Any,AbstractString}()
        for j in 1:n
          mymap[categories[j]] = string('C', j)
        end
        output_df[index] = map(x->mymap[x], collect(df[i]))
        index += 1
      else
      # Replace categoric variables with binaries
        for j in 2:n
          output_df[index] = intorna(df[i] .== categories[j])
          index += 1
        end
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
      # process the column only when it's numeric
      # leave alone when keepcat=true gives a string
      if !isa(output_df[j], DataArray{String})
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
  end

  output_path = joinpath(processed_path, name)

  if problemtype == "classification"
    if class_size == -1
      class_size = length(levels(pool(df[target_index])))
    end

    if class_size == 0
      output_df[:class] = df[target_index]
      writetable(output_path, output_df, separator=',', header=false)
    elseif class_size == 1
      classes = levels(pool(df[target_index]))
      # Skip the first class so we only output 1 files for 2 classes
      if length(classes) == 2
        classes = classes[2:end]
      end
      for (i, class) in enumerate(classes)
        newclass = df[target_index] .== class
        # Make sure the output has enough records
        if sum(newclass) < min_size || sum(1 - newclass) < min_size
          continue
        end
        output_df[:class] = intorna(newclass)
        writetable("$output_path.$i", output_df, separator=',', header=false)
      end
    else
      classes = levels(pool(df[target_index]))
      output_df[:class] = 0

      for comb in combinations(1:length(classes), class_size)
        output_rows = Int64[]
        output = true
        for i in 1:class_size
          rows = df[target_index] .== classes[comb[i]]
          # Make sure the output has enough records
          if sum(rows) < min_size
            output = false
            break
          end
          append!(output_rows, find(rows))
          output_df[rows, :class] = i - 1
        end
        if output
          outputsuffix = join(comb, ".")
          writetable("$output_path.$outputsuffix",
                     output_df[output_rows, :], separator=',', header=false)
        end
      end
    end
  elseif problemtype == "regression"
    if normalize
      min = minimum(df[target_index])
      max = maximum(df[target_index])
      df[target_index] = (df[target_index] - min) / (max - min)
    end
    output_df[:class] = df[target_index]
    writetable(output_path, output_df, separator=',', header=false)
  end
end

function processalldirs(problemtype::String, normalize::Bool=false, keepcat::Bool=false,
                        class_size::Int=0, min_size::Int=0)

  root_path = dirname(@__FILE__)
  datafiles_path = joinpath(root_path, "datafiles", problemtype)

  normalize_path = normalize ? "normalized" : "original"
  categoric_path = keepcat ? "_categoric" : ""
  comb_path = "$(normalize_path)$(categoric_path)"

  processed_path = joinpath(root_path, "processed", problemtype, comb_path)

  if problemtype == "classification"
    class_size_path = class_size > 0 ? "$class_size" : "all"
    processed_path = joinpath(processed_path, class_size_path)
  end

  mkpath(processed_path)

  for dir in readdir(datafiles_path)
    data_path = joinpath(datafiles_path, dir)
    if !isdir(data_path)
      continue
    end
    println("Processing $dir")
    processdir(data_path, processed_path, problemtype, normalize, keepcat, class_size,
               min_size)
  end
end
