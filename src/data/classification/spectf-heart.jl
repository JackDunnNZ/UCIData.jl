using DataDeps

register(DataDep(
  "spectf-heart",
  "http://archive.ics.uci.edu/ml/datasets/SPECTF+Heart",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/spect/SPECTF.train",
  "9c837e4fd4b7931d9be5304989e39f284f35f767518ffd4dfd42a6a519a9f30c",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:45,
    )
  end),
))
