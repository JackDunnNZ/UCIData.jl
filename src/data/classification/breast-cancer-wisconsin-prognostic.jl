register(DataDep(
  "breast-cancer-wisconsin-prognostic",
  "http://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Prognostic%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wpbc.data",
  "f2bd5ccdb6086fa832370dc043319907430cf6bfcfd3b96a3961a357be345c8e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=2,
        feature_indices=4:35,
        id_indices=1,
    )
  end),
))
