using DataDeps

register(DataDep(
  "lenses",
  "http://archive.ics.uci.edu/ml/datasets/Lenses",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/lenses/lenses.data",
  "711f22d5a4bed062bb715d39d23d54d2667206fbd97c94c7fd013ede47fb96c2",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=6,
        feature_indices=2:5,
        id_indices=1,
        categoric_indices=2:5,
        separator=' ',
    )
  end),
))
