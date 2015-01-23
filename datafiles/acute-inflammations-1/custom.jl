# The , as a decimal separator isn't yet supported by DataFrames
# We replace all , with . as a workaround

dataset_path = "datafiles/acute-inflammations-1/acute-inflammations-1.data.orig"

f = open(dataset_path)
data = utf16(readbytes(f))
close(f)

data = replace(data, ",", ".")

f = open("$dataset_path.custom", "w")
write(f, data)
close(f)
