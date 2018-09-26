using DataDeps

register(DataDep(
  "spambase",
  "http://archive.ics.uci.edu/ml/datasets/Spambase",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data",
  "b1ef93de71f97714d3d7d4f58fc9f718da7bbc8ac8a150eff2778616a8097b12",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=58,
        feature_indices=1:57,
    )
  end),
))
