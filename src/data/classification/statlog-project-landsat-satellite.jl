using DataDeps

register(DataDep(
  "statlog-project-landsat-satellite",
  "http://archive.ics.uci.edu/ml/datasets/Statlog+Project",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/statlog/satimage/sat.trn",
  "e896dc88a960fa2404160fc4c3cb3dc53fcf4afd80ba920bf2d261bd42d12613",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=37,
        feature_indices=1:36,
        separator=' ',
    )
  end),
))
