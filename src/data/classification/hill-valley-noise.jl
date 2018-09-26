using DataDeps

register(DataDep(
  "hill-valley-noise",
  "http://archive.ics.uci.edu/ml/datasets/Hill-Valley",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/hill-valley/Hill_Valley_with_noise_Training.data",
  "aef62398c3a215452bcf4ce5c6a87207a3dc8e79631ef87a6eda6fe3896bc966",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=101,
        feature_indices=1:100,
        skipstart=1,
    )
  end),
))
