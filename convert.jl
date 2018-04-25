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

function get_extrema(dataarray::DataArray)
  input = convert(Vector{Float64}, dataarray[.!isna.(dataarray)])
  if length(input) > 0
    return extrema(input)
  else
    return 0, 0
  end
end

function processdir(data_path::String, processed_path::String,
                    problemtype::String, keepcat::Bool,
                    keepna::Bool)
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

  if !keepna
    completecases!(df)
  end

  num_rows = size(df, 1)

  if num_rows == 0
    return
  end

  output_df = DataFrame()
  output_names = Vector{Symbol}()
  output_df[:id] = [makeid(df, i, id_indices) for i in 1:size(df, 1)]
  push!(output_names, :id)

  # Construct output values
  index = 2
  for i in value_indices
    if i in categoric_indices
      if keepcat
        output_df[index] = map(x->isna(x)? NA : string(x), df[i])
        push!(output_names, convert(Symbol, string("C", index - 1)))
        index += 1
      else
        # Replace categoric variables with binaries
        categories = levels(pool(df[i]))
        for j in 2:length(categories)
          output_df[index] = intorna(df[i] .== categories[j])
          push!(output_names, convert(Symbol, string("N", index - 1)))
          index += 1
        end
      end
    else
      output_df[index] = df[i]
      push!(output_names, convert(Symbol, string("N", index - 1)))
      index += 1
    end
  end

  # Naming the output_df with categoric or numeric
  names!(output_df, output_names)
  output_path = joinpath(processed_path, name)

  if problemtype == "classification"
    output_df[:target] = string.(df[target_index])
  elseif problemtype == "regression"
    output_df[:target] = df[target_index]
  end
  writetable(output_path, output_df, separator=',', header=true)
end

function processalldirs(problemtype::String, keepcat::Bool=false,
                        keepna::Bool=false)

  root_path = @__DIR__
  datafiles_path = joinpath(root_path, "datafiles", problemtype)

  categoric_path = keepcat ? "categoric" : "onehot"
  na_path = keepna ? "_missing" : ""

  comb_path = "$(categoric_path)$(na_path)"

  processed_path = joinpath(root_path, "processed", problemtype, comb_path)

  mkpath(processed_path)

  for dir in readdir(datafiles_path)
    data_path = joinpath(datafiles_path, dir)
    if !isdir(data_path)
      continue
    end
    println("Processing $dir")
    processdir(data_path, processed_path, problemtype, keepcat, keepna)
  end
end
