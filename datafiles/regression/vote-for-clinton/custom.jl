#data set has names at the beginning of it. Since the parts of the names have spaces in between them and a space is the seperator for the
#rest of the file, it gets confused how many colums exist

dataset_path = joinpath(dirname(@__FILE__), "vote-for-clinton.data.orig")

f = open("$dataset_path.custom", "w")
for line in readlines(dataset_path)
  line = line[30:end]
  line = lstrip(line)
  write(f, "$line\n")
end
close(f)
