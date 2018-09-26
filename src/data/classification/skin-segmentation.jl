using DataDeps

register(DataDep(
  "skin-segmentation",
  "http://archive.ics.uci.edu/ml/datasets/Skin+Segmentation",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00229/Skin_NonSkin.txt",
  "e30c0a845385dcc95a45c45ed263465674a49638e98ef740afd520769c7714a4",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=4,
        feature_indices=1:3,
        separator=' ',
    )
  end),
))
