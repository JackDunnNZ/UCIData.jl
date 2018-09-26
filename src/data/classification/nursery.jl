using DataDeps

register(DataDep(
  "nursery",
  "http://archive.ics.uci.edu/ml/datasets/Nursery",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/nursery/nursery.data",
  "8e0389c3dd37590248a921c2726d869ee96b817761a35eb8416afa24f31f931d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=1:8,
        categoric_indices=1:8,
    )
  end),
))
