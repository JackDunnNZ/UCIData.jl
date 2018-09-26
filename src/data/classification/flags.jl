using DataDeps

register(DataDep(
  "flags",
  "http://archive.ics.uci.edu/ml/datasets/Flags",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/flags/flag.data",
  "ff7061c0838b2916906040057a2fb6505b5ed43c7f4a231a2c59d0e37bdac3fb",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=7,
        feature_indices=[2:6; 8:30],
        id_indices=1,
        categoric_indices=[2:3; 6; 18; 29:30],
    )
  end),
))
