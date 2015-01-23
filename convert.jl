using ConfParser
using DataFrames

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

function processDir(data_path::String, processed_path::String)
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

  output_df = DataFrame()
  output_df[:id] = [makeId(df, i, id_indices) for i in 1:size(df, 1)]
  output_df[1+(1:length(value_indices))] = df[value_indices]
  output_df[:n_class] = df[class_index]

  mkpath(processed_path)
  output_path = joinpath(processed_path, name)
  writetable(output_path, output_df, separator=',', header=false)
end

function processAllDirs()
  root_path = dirname(Base.source_path())
  datafiles_path = joinpath(root_path, "datafiles")
  println("$datafiles_path")

  processed_path = joinpath(root_path, "processed")
  mkpath(processed_path)

  for dir in readdir(datafiles_path)
    data_path = joinpath(datafiles_path, dir)
    if !isdir(data_path)
      continue
    end
    println("Processing $dir")
    processDir(data_path, joinpath(processed_path, dir))
  end
end

processAllDirs()
