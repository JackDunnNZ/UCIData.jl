using DataDeps

register(DataDep(
  "soybean-small",
  "http://archive.ics.uci.edu/ml/datasets/Soybean+%28Large%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/soybean/soybean-small.data",
  "f096d1675db0270071311c9f46813b204372370bd68252a5a417bdcff5879717",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=36,
        feature_indices=1:35,
        categoric_indices=1:35,
    )
  end),
))
