# The , as a decimal separator isn't yet supported by DataFrames
# We replace all , with . as a workaround

import LegacyStrings

dataset_path = joinpath(dirname(@__FILE__), "acute-inflammations-1.data.orig")

f = open(dataset_path)
data = LegacyStrings.utf16(read(f)[3:end])
close(f)

data = replace(data, ",", ".")

f = open("$dataset_path.custom", "w")
write(f, data)
close(f)
