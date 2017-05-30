# There is a misplaced leading comma on line 50, we should get rid of it


dataset_path = joinpath(dirname(@__FILE__), "echocardiogram.data.orig")

f = open(dataset_path)
data = readlines(f)
close(f)

f = open("$dataset_path.custom", "w")
for (i, line) in enumerate(data)
  if i == 50
    line = line[2:end]
  end
  write(f, "$line")
end
close(f)
