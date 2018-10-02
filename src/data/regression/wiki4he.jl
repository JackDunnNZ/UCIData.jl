using DataDeps

register(DataDep(
  "wiki4he",
  "https://archive.ics.uci.edu/ml/datasets/wiki4HE",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00334/wiki4HE.csv",
  "2270c9b4cc6a9492c740f2bd42a2fee23c7afab383ec31364b08365cc1d43ae2",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:53,
        categoric_indices=[2:4; 6:10],
        delim=';',
        skipto=2,
    )
  end),
))
