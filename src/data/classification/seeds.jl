using DataDeps

register(DataDep(
  "seeds",
  "http://archive.ics.uci.edu/ml/datasets/seeds",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00236/seeds_dataset.txt",
  "1f3f83c0d8485ae9148061389d19628607e3f5660e3d6f40ec9102fb398bb12f",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=8,
        feature_indices=1:7,
        separator=' ',
    )
  end),
))
