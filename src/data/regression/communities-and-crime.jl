register(DataDep(
  "communities-and-crime",
  "https://archive.ics.uci.edu/ml/datasets/Communities+and+Crime",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/communities/communities.data",
  "09e0b5c07eae24c1efab19b2edee05e160e7f5743b6f31e31eec3d73624da2ea",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=128,
        feature_indices=6:127,
        id_indices=4,
    )
  end),
))
