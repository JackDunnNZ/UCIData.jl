module UCIData


import CSV
using DataDeps
using DataFrames
import LegacyStrings


const DATA_DIR = joinpath(@__DIR__, "data")


include("convert.jl")


function dataset(datasetname)
  dataset_path = @datadep_str datasetname

  df = readtable("$dataset_path/data.csv", header=true)
  for name in names(df)
    if string(name)[1] == 'C'
      pool!(df, name)
    end
  end

  df
end

function list_dataset_types()
  filter(x -> isdir(joinpath(DATA_DIR, x)), readdir(DATA_DIR))
end

function list_datasets(datasettype)
  dir = joinpath(DATA_DIR, datasettype)
  datasets = filter(x -> splitext(x)[end] == ".jl", readdir(dir))
  map(x -> splitext(x)[1], datasets)
end

function __init__()
  for datasettype in list_dataset_types()
    for dataset in list_datasets(datasettype)
      include(joinpath(DATA_DIR, datasettype, "$dataset.jl"))
    end
  end
end


end
