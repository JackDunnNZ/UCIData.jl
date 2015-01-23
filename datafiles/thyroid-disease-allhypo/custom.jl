# The ids are appended to each row after `.|`. Replace with comma

dataset_path = "datafiles/thyroid-disease-allhypo/thyroid-disease-allhypo.data.orig"

f = open(dataset_path)
data = readlines(f)
close(f)

f = open("$dataset_path.custom", "w")
for line in data
  line = replace(line, ".|", ",")
  write(f, line)
end
close(f)
