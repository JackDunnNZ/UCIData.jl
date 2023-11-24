module UCIData


import CSV
using CategoricalArrays

using DataFrames
using DelimitedFiles
using Dates
using DataDeps: DataDeps

# Our `register` will push a registration function into `REGISTER`.
# Then at `__init__` time, we will call these to register them
# with DataDeps. This allows us to call `register` at precompilation
# time, so we can include separate files each with a `register` call,
# but do the registration at runtime, as DataDeps requires.
const REGISTRY = []
function register(args...; kwargs...)
    push!(REGISTRY, () -> DataDeps.register(args...; kwargs...))
end

const DATA_DIR = joinpath(@__DIR__, "data")


include("convert.jl")


function dataset(datasetname)
  dataset_path = @datadep_str datasetname

  df = CSV.read("$dataset_path/data.csv", DataFrame, header=true,
                typemap=Dict(Date=>String, DateTime=>String))
  for name in names(df)
    if name[1] == 'C'
      transform!(df, name => categorical, renamecols=false)
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

for datasettype in list_dataset_types()
    for dataset in list_datasets(datasettype)
      include(joinpath(DATA_DIR, datasettype, "$dataset.jl"))
    end
end

function __init__()
    for f in REGISTRY
        f()
    end
end


end
