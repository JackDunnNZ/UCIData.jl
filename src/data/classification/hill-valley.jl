using DataDeps

register(DataDep(
  "hill-valley",
  "http://archive.ics.uci.edu/ml/datasets/Hill-Valley",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/hill-valley/Hill_Valley_without_noise_Training.data",
  "af232ff5258abeb5b1c61974648fd00bc0d37a545de33a2c3493692fc20330d5",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=101,
        feature_indices=1:100,
        skipstart=1,
    )
  end),
))
