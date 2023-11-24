register(DataDep(
  "wall-following-robot-navigation-4",
  "http://archive.ics.uci.edu/ml/datasets/Wall-Following+Robot+Navigation+Data",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00194/sensor_readings_4.data",
  "3e2f8ec98af5cc66d31b120222f92c0fbfd5033bbc78e50f8edf74f2e236c9ee",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
    )
  end),
))
