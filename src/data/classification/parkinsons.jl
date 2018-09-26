using DataDeps

register(DataDep(
  "parkinsons",
  "http://archive.ics.uci.edu/ml/datasets/Parkinsons",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/parkinsons/parkinsons.data",
  "a36116c2deac07895b79ce97a2f99a1b3720ac4892995ff5c3b9ccb397ed2bc5",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=18,
        feature_indices=[2:17; 19:23],
        id_indices=1,
        skipstart=1,
    )
  end),
))
