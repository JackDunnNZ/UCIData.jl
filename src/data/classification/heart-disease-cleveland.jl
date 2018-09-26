using DataDeps

register(DataDep(
  "heart-disease-cleveland",
  "http://archive.ics.uci.edu/ml/datasets/Heart+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data",
  "a74b7efa387bc9d108d7d0115d831fe9b414b29ae7124f331b622b4efa0427c8",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=14,
        feature_indices=1:13,
        categoric_indices=[3; 7; 11; 13],
    )
  end),
))
