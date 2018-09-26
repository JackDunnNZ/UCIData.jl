using DataDeps

register(DataDep(
  "monks-problems-2",
  "http://archive.ics.uci.edu/ml/datasets/MONK%27s+Problems",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/monks-problems/monks-2.train",
  "7ebcc278005737caad0cd52e6aa31256a2c3174da8047faf4ac3a9d35edbdaa8",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:7,
        id_indices=8,
        categoric_indices=2:7,
        separator=' ',
    )
  end),
))
