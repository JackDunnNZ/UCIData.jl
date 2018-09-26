using DataDeps

register(DataDep(
  "magic-gamma-telescope",
  "http://archive.ics.uci.edu/ml/datasets/MAGIC+Gamma+Telescope",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/magic/magic04.data",
  "e9314b7ebd4b4b59a3b3d65f7316663963777b16a46786877651dbbaa640b36a",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=1:10,
    )
  end),
))
