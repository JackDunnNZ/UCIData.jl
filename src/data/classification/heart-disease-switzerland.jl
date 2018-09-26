using DataDeps

register(DataDep(
  "heart-disease-switzerland",
  "http://archive.ics.uci.edu/ml/datasets/Heart+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.switzerland.data",
  "834a405ccf5b66ab4056bb77794adc8df0b7125186454c0a1d002d33c6c3b314",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=14,
        feature_indices=1:13,
        categoric_indices=[3; 7; 11; 13],
    )
  end),
))
