using DataDeps

register(DataDep(
  "horse-colic",
  "http://archive.ics.uci.edu/ml/datasets/Horse+Colic",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/horse-colic/horse-colic.data",
  "270db486c78796143ffa84b4808118b3d4b96d1bd0f70bf22b3bb0bfca21e547",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=24,
        feature_indices=1:22,
        categoric_indices=[7:9; 11:12; 15; 17:18; 21],
        separator=' ',
    )
  end),
))
