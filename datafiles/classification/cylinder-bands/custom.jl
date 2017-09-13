# There is a misplaced line break on line 522, we should get rid of it


dataset_path = joinpath(dirname(@__FILE__), "cylinder-bands.data.orig")

f = open(dataset_path)
data = readlines(f)
close(f)

f = open("$dataset_path.custom", "w")
for (i, line) in enumerate(data)
  line = rstrip(line)
  if i == 522
    write(f, "$line$(rstrip(data[i+1]))\n")
  elseif i != 523
    write(f, "$line\n")
  end
end
close(f)
