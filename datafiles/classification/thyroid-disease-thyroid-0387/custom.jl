# The ids are appended to each row inside []`. Replace with comma separation.


dataset_path = joinpath(dirname(@__FILE__),
                        "thyroid-disease-thyroid-0387.data.orig")

f = open(dataset_path)
data = readlines(f)
close(f)

f = open("$dataset_path.custom", "w")
for line in data
  line = replace(line, "[", ",")
  line = replace(line, "]", "")
  write(f, line)
end
close(f)


data = readstring(dataset_path)
write("$dataset_path.custom", replace(replace(data, "[", ","), "]", ""))