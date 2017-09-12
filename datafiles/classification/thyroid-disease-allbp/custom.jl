# The ids are appended to each row after `.|`. Replace with comma


dataset_path = joinpath(dirname(@__FILE__), "thyroid-disease-allbp.data.orig")

data = readstring(dataset_path)
write("$dataset_path.custom", replace(data, ".|", ","))