register(DataDep(
  "poker-hand",
  "http://archive.ics.uci.edu/ml/datasets/Poker+Hand",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/poker/poker-hand-training-true.data",
  "37becdf87d5f8cbf2b91d6471e965a25b86cb4a6d878c0f94a4025969fca464f",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=1:10,
    )
  end),
))
