register(DataDep(
  "mushroom",
  "http://archive.ics.uci.edu/ml/datasets/Mushroom",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data",
  "e65d082030501a3ebcbcd7c9f7c71aa9d28fdfff463bf4cf4716a3fe13ac360e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:23,
        categoric_indices=2:23,
    )
  end),
))
