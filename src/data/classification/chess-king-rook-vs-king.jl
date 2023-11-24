register(DataDep(
  "chess-king-rook-vs-king",
  "http://archive.ics.uci.edu/ml/datasets/Chess+%28King-Rook+vs.+King%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/chess/king-rook-vs-king/krkopt.data",
  "497b61d20d3d9e2ce310f9f4d2ca92dbdb0691d9e449d983ec6f7baf387dc7a9",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=7,
        feature_indices=1:6,
        categoric_indices=1:6,
    )
  end),
))
