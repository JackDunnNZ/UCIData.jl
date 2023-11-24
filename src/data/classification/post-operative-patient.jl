register(DataDep(
  "post-operative-patient",
  "http://archive.ics.uci.edu/ml/datasets/Post-Operative+Patient",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/postoperative-patient-data/post-operative.data",
  "dca524352b089db5417ac78c0e4aeb5f1753bc5265aec82568c2dbcbc1461a2e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=1:8,
        categoric_indices=1:7,
    )
  end),
))
