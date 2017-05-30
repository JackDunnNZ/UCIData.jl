# The whitespace in this file is weird. Pass through tr first, then remove
# extra commas


dataset_path = joinpath(dirname(@__FILE__),
                        "climate-model-simulation-crashes.data.orig")

data = readlines(pipeline(`cat $dataset_path`, `tr -s '[:blank:]' ','`))

f = open("$dataset_path.custom", "w")
for line in data
  line = rstrip(line)
  # Trim leading comma
  if line[1] == ','
    line = line[2:end]
  end
  # Trim trailing comma
  if line[end] == ','
    line = line[1:end - 1]
  end
  write(f, "$line\n")
end
close(f)
