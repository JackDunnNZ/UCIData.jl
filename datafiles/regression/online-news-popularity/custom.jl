# The file in the zip file doesn't follow the same naming convention

dataset_path = joinpath(dirname(@__FILE__), "online-news-popularity.data.orig")
download_path = joinpath(dirname(@__FILE__), "online-news-popularity.data.zip")

unzipped_dir = ZipFile.Reader(download_path)
for file in unzipped_dir.files
    if basename(file.name) == "OnlineNewsPopularity.csv"
      write("$dataset_path.custom", readstring(file))
    end
end
