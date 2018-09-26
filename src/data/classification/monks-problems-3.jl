using DataDeps

register(DataDep(
  "monks-problems-3",
  "http://archive.ics.uci.edu/ml/datasets/MONK%27s+Problems",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/monks-problems/monks-3.train",
  "726f258f80be06af4bb2d8831789514a663f5813e47429211fe19dcd367966f8",
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
