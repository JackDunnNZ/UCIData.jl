using DataDeps

register(DataDep(
  "heart-disease-hungarian",
  "http://archive.ics.uci.edu/ml/datasets/Heart+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.hungarian.data",
  "d1ad108f785768cd3d7e82dc522e6f5a61eea93cccfb3a46ee8076f73fc3d796",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=14,
        feature_indices=1:13,
        categoric_indices=[3; 7; 11; 13],
    )
  end),
))
