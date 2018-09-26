using DataDeps

register(DataDep(
  "thyroid-disease-new-thyroid",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/new-thyroid.data",
  "0760039b928ecba5170f377b8fd96caaf55ed26f9861511c52f81395a9d8227a",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:6,
    )
  end),
))
