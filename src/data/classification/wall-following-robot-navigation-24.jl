using DataDeps

register(DataDep(
  "wall-following-robot-navigation-24",
  "http://archive.ics.uci.edu/ml/datasets/Wall-Following+Robot+Navigation+Data",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00194/sensor_readings_24.data",
  "6e9728dedef8b35e31ba0be11aea85aa53bd248ab33652777df81b95a4cc8c00",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=25,
        feature_indices=1:24,
    )
  end),
))
