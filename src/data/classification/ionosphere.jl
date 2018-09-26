using DataDeps

register(DataDep(
  "ionosphere",
  "http://archive.ics.uci.edu/ml/datasets/Ionosphere",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data",
  "46d52186b84e20be52918adb93e8fb9926b34795ff7504c24350ae0616a04bbd",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=35,
        feature_indices=1:34,
    )
  end),
))
