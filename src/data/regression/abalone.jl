register(DataDep(
  "abalone",
  "https://archive.ics.uci.edu/ml/datasets/Abalone",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data",
  "de37cdcdcaaa50c309d514f248f7c2302a5f1f88c168905eba23fe2fbc78449f",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=1:8,
        categoric_indices=1,
    )
  end),
))
