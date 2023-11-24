register(DataDep(
  "breast-cancer-wisconsin-diagnostic",
  "http://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data",
  "d606af411f3e5be8a317a5a8b652b425aaf0ff38ca683d5327ffff94c3695f4a",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=2,
        feature_indices=3:32,
        id_indices=1,
    )
  end),
))
