using DataDeps

register(DataDep(
  "lung-cancer",
  "http://archive.ics.uci.edu/ml/datasets/Lung+Cancer",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/lung-cancer/lung-cancer.data",
  "5fe074a5e4b44816e958b3f37503b1357a1543daa7eee77485040b0e3aef18f1",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:57,
        categoric_indices=2:57,
    )
  end),
))
