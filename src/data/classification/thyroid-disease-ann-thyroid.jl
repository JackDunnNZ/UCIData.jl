using DataDeps

register(DataDep(
  "thyroid-disease-ann-thyroid",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/ann-train.data",
  "3da53a156bda36cb0c97e9f4b6b111c9226c54c4aa00230de5604b787c47e3a6",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=22,
        feature_indices=1:21,
        separator=' ',
    )
  end),
))
