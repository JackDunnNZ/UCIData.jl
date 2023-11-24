register(DataDep(
  "balloons-d",
  "http://archive.ics.uci.edu/ml/datasets/Balloons",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/balloons/yellow-small+adult-stretch.data",
  "75aa5e6638fbeaae88b508a188f74c22e7bb2d64f2abac9f6db82d86ee068041",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
        categoric_indices=1:4,
    )
  end),
))
