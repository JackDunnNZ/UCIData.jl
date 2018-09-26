using DataDeps

register(DataDep(
  "car-evaluation",
  "http://archive.ics.uci.edu/ml/datasets/Car+Evaluation",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data",
  "b703a9ac69f11e64ce8c223c0a40de4d2e9d769f7fb20be5f8f2e8a619893d83",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=7,
        feature_indices=1:6,
        categoric_indices=1:6,
    )
  end),
))
