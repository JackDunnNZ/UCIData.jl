# The missing values are `-`. Replace with `?`


dataset_path = joinpath(dirname(@__FILE__), "trains.data.orig")

f = open(dataset_path)
data = readlines(f)
close(f)

f = open("$dataset_path.custom", "w")
for line in data
  line = replace(line, "-", "?")
  write(f, line)
end
close(f)
