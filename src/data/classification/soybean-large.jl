register(DataDep(
  "soybean-large",
  "http://archive.ics.uci.edu/ml/datasets/Soybean+%28Large%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/soybean/soybean-large.data",
  "04b99f2728ded9f544022d2b4f6cce0ebe11ef5c9d44f10e21acd7093876507e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:36,
        categoric_indices=2:36,
    )
  end),
))
