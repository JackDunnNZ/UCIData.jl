using DataDeps

register(DataDep(
  "ozone-level-detection-eight",
  "https://archive.ics.uci.edu/ml/datasets/Ozone+Level+Detection",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/ozone/eighthr.data",
  "9a24c3e5c43570148869fec02edcd44dd1cb06e97c2bbc0b6ab24ebdd21de37e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=74,
        feature_indices=2:73,
        id_indices=1,
    )
  end),
))
