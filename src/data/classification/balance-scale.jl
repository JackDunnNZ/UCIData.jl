register(DataDep(
  "balance-scale",
  "http://archive.ics.uci.edu/ml/datasets/Balance+Scale",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/balance-scale/balance-scale.data",
  "5611187ef7345d807aa8ae22615945ade52a190537c0b1434bd44c3e877c5bb4",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:5,
    )
  end),
))
