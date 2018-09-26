using DataDeps

register(DataDep(
  "housing",
  "https://archive.ics.uci.edu/ml/datasets/Housing",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data",
  "baadf72995725d76efe787b664e1f083388c79ba21ef9a7990d87f774184735a",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=14,
        feature_indices=1:13,
        separator=' ',
    )
  end),
))
