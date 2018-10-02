using DataDeps

register(DataDep(
  "wine-quality-white",
  "https://archive.ics.uci.edu/ml/datasets/Wine+Quality",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv",
  "76c3f809815c17c07212622f776311faeb31e87610d52c26d87d6e361b169836",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=12,
        feature_indices=1:11,
        delim=';',
        skipto=2,
    )
  end),
))
