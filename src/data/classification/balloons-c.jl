register(DataDep(
  "balloons-c",
  "http://archive.ics.uci.edu/ml/datasets/Balloons",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/balloons/yellow-small.data",
  "0b7b20edf6108fc46846ee685c8175797fb1925714c66c0e7d6cfa027464d934",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
        categoric_indices=1:4,
    )
  end),
))
