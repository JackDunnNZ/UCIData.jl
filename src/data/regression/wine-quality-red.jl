using DataDeps

register(DataDep(
  "wine-quality-red",
  "https://archive.ics.uci.edu/ml/datasets/Wine+Quality",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv",
  "4a402cf041b025d4566d954c3b9ba8635a3a8a01e039005d97d6a710278cf05e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=12,
        feature_indices=1:11,
        delim=';',
        skipto=2,
    )
  end),
))
