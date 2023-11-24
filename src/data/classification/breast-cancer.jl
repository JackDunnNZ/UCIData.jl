register(DataDep(
  "breast-cancer",
  "http://archive.ics.uci.edu/ml/datasets/Breast+Cancer",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer/breast-cancer.data",
  "ca7d3fa97b62ff967b6894ffbb3acaaf4a51062e0149e5950b3ad6f685970b65",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:10,
        categoric_indices=[2:6; 8:10],
    )
  end),
))
