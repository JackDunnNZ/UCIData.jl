using DataDeps

register(DataDep(
  "ozone-level-detection-one",
  "https://archive.ics.uci.edu/ml/datasets/Ozone+Level+Detection",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/ozone/onehr.data",
  "342aceeafccd3994b2f5ee70c80f825e5d2d11e3224a83b3cc05fd11acaa7121",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=74,
        feature_indices=2:73,
        id_indices=1,
    )
  end),
))
