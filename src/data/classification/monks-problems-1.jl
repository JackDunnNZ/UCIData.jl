using DataDeps

register(DataDep(
  "monks-problems-1",
  "http://archive.ics.uci.edu/ml/datasets/MONK%27s+Problems",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/monks-problems/monks-1.train",
  "d9c328b6f0e095ab10f7bc8468f1d2141f3d08be73e665c3bf0a62994c922606",
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
