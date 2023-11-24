register(DataDep(
  "breast-cancer-wisconsin-original",
  "http://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Original%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data",
  "402c585309c399237740f635ef9919dc512cca12cbeb20de5e563a4593f22b64",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=2:10,
        id_indices=1,
    )
  end),
))
