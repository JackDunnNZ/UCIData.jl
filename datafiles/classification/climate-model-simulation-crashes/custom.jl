# The whitespace in this file is weird. Read in and out as csv to normalize whitespace


dataset_path = joinpath(dirname(@__FILE__),
                        "climate-model-simulation-crashes.data.orig")

data = readdlm(dataset_path)
writecsv("$dataset_path.custom", data[:, 1:end - 1])
