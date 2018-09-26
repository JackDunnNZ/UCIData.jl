using DataDeps

register(DataDep(
  "wine",
  "http://archive.ics.uci.edu/ml/datasets/Wine",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data",
  "6be6b1203f3d51df0b553a70e57b8a723cd405683958204f96d23d7cd6aea659",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:14,
    )
  end),
))
