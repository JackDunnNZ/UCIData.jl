using DataDeps

register(DataDep(
  "wall-following-robot-navigation-2",
  "http://archive.ics.uci.edu/ml/datasets/Wall-Following+Robot+Navigation+Data",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00194/sensor_readings_2.data",
  "901f0027c108917e47ee4e67beda95d6e81b598646c05383816db6905915983d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=3,
        feature_indices=1:2,
    )
  end),
))
