register(DataDep(
  "balloons-a",
  "http://archive.ics.uci.edu/ml/datasets/Balloons",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/balloons/adult-stretch.data",
  "303b73451b87ca234bc93de6a2bb7e87f86d033a0e7cf23bab4fd3e74c9e6ffa",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
        categoric_indices=1:4,
    )
  end),
))
