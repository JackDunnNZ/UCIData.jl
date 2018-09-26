using DataDeps

register(DataDep(
  "zoo",
  "http://archive.ics.uci.edu/ml/datasets/Zoo",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/zoo/zoo.data",
  "cddc71c26ab9bc82795b8f4ff114cade41885d92720c6af29ffb69bcf73f0315",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=18,
        feature_indices=2:17,
        id_indices=1,
        categoric_indices=[2:13; 15:17],
    )
  end),
))
