using DataDeps

register(DataDep(
  "tic-tac-toe-endgame",
  "http://archive.ics.uci.edu/ml/datasets/Tic-Tac-Toe+Endgame",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data",
  "a996a756484d0cf8cbad1680d823aadbfcff8ae2d78c450e6999362d580301c5",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=10,
        feature_indices=1:9,
        categoric_indices=1:9,
    )
  end),
))
