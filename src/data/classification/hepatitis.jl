using DataDeps

register(DataDep(
  "hepatitis",
  "http://archive.ics.uci.edu/ml/datasets/Hepatitis",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/hepatitis/hepatitis.data",
  "9971f9d18abb4fc9dd6749eefb0f864b36fa7bdd59f54188c0b148a5c28214bc",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:20,
    )
  end),
))
