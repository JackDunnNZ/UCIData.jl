# There are two files in .gz with .data extension, need to pick the right one

dataset_path = joinpath(dirname(@__FILE__), "cpu-small.data.orig")
file_path = joinpath(dirname(@__FILE__), "cpu-small.data.gz-contents",
                     "cpu_small.data")

write("$dataset_path.custom", readstring(file_path))
