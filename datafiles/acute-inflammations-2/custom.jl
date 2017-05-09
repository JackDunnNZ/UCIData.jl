# The , as a decimal separator isn't yet supported by DataFrames
# We replace all , with . as a workaround

import LegacyStrings

dataset_path = "datafiles/acute-inflammations-2/acute-inflammations-2.data.orig"

f = open(dataset_path)
data = LegacyStrings.utf16(read(f))
close(f)

data = replace(data, ",", ".")

f = open("$dataset_path.custom", "w")
write(f, data)
close(f)
