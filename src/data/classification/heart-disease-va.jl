using DataDeps

register(DataDep(
  "heart-disease-va",
  "http://archive.ics.uci.edu/ml/datasets/Heart+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.va.data",
  "e7c93d8d0d2acdadfa4c5e8de768e2191e7f618b952e29623f1f0d5949ff6b8f",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=14,
        feature_indices=1:13,
        categoric_indices=[3; 7; 11; 13],
    )
  end),
))
