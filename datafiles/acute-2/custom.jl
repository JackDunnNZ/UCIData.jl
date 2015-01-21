# The , as a decimal separator isn't yet supported by DataFrames
# We replace all , with . as a workaround

dataset_path = "datafiles/acute-2/acute-2.data.orig"

f = open(dataset_path)
data = utf16(readbytes(f))
close(f)

data = replace(data, ",", ".")

f = open(dataset_path, "w")
write(f, data)
close(f)
