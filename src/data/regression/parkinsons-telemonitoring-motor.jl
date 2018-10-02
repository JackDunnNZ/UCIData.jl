using DataDeps

register(DataDep(
  "parkinsons-telemonitoring-motor",
  "https://archive.ics.uci.edu/ml/datasets/Parkinsons+Telemonitoring",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/parkinsons/telemonitoring/parkinsons_updrs.data",
  "f2c7d5025dec4e92e7feae367a5f7ccf58789a10ac6b54bdf15976c599f9dd39",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=7:22,
        skipto=2,
    )
  end),
))
