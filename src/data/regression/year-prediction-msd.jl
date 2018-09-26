using DataDeps

register(DataDep(
  "year-prediction-msd",
  "http://archive.ics.uci.edu/ml/datasets/YearPredictionMSD",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00203/YearPredictionMSD.txt.zip",
  "06f801af323bb7798e800583acce4ea1ed2697ac12c23f4424aea0a7a3d09e11",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "YearPredictionMSD.txt")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:91,
    )
  end),
))
