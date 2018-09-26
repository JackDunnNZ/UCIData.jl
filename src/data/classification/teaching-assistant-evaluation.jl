using DataDeps

register(DataDep(
  "teaching-assistant-evaluation",
  "http://archive.ics.uci.edu/ml/datasets/Teaching+Assistant+Evaluation",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/tae/tae.data",
  "e83ec0a1000f4d2a7d19de9de2fc8c381357304c5c8ff942779136a9e0eefca4",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=6,
        feature_indices=1:5,
        categoric_indices=1:4,
    )
  end),
))
