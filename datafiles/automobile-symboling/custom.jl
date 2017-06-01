# There are two columns with numbers in text form
using EnglishText

dataset_path = joinpath(dirname(@__FILE__), "automobile-symboling.data.orig")

data = readcsv(dataset_path, header=false)
for col in [6; 16]
    data[:, col] = map(x -> x == "?" ? "?" : unenglish(Int, x), data[:, col])
end

writecsv("$dataset_path.custom", data, header=false)
