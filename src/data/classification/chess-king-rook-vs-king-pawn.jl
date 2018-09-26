using DataDeps

register(DataDep(
  "chess-king-rook-vs-king-pawn",
  "http://archive.ics.uci.edu/ml/datasets/Chess+%28King-Rook+vs.+King-Pawn%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/chess/king-rook-vs-king-pawn/kr-vs-kp.data",
  "70a5540902b4063d3977d3e820ac5b9fe5624eb5d93709eee5d50d7a94fca205",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=37,
        feature_indices=1:36,
        categoric_indices=1:36,
    )
  end),
))
