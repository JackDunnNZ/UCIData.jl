using DataDeps

register(DataDep(
  "automobile",
  "https://archive.ics.uci.edu/ml/datasets/Automobile",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data",
  "125db8bd36a84801f7223faf54071d15f85f26c13a9a7aee63375ac46098fb7f",
  post_fetch_method=(path -> begin
    # There are two columns with numbers in text form
    data = read(path, String)
    data = replace(data, "two", 2)
    data = replace(data, "three", 3)
    data = replace(data, "four", 4)
    data = replace(data, "five", 5)
    data = replace(data, "six", 6)
    data = replace(data, "eight", 8)
    data = replace(data, "twelve", 12)
    write(path, data)

    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:26,
        categoric_indices=[3:5; 7:9; 15; 18],
    )
  end),
))
