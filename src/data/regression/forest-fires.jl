using DataDeps

register(DataDep(
  "forest-fires",
  "https://archive.ics.uci.edu/ml/datasets/Forest+Fires",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.csv",
  "0d6586a1fa52f55bef48578aef14eb97273f1e9330e1a53423df497a77065253",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=13,
        feature_indices=1:12,
        categoric_indices=3:4,
        skipstart=1,
    )
  end),
))
