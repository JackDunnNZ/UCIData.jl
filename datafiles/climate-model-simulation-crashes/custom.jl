# The , as a decimal separator isn't yet supported by DataFrames
# We replace all , with . as a workaround

dataset_path = "datafiles/climate-model-simulation-crashes/climate-model-simulation-crashes.data.orig"

# f = open(dataset_path)
# data = readbytes(f)
# close(f)

# println(data)

# data = replace(data, ",", ".")


data = readlines(`cat $dataset_path` |> `tr -s '[:blank:]' ','`)

f = open(dataset_path, "w")
for line in data
  line = rstrip(line)
  # Trim leading comma
  if line[1] == ','
    line = line[2:end]
  end
  if line[end] == ','
    line = line[1:end - 1]
  end
  write(f, "$line\n")
end
close(f)
