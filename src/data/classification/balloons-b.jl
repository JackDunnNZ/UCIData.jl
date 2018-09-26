using DataDeps

register(DataDep(
  "balloons-b",
  "http://archive.ics.uci.edu/ml/datasets/Balloons",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/balloons/adult+stretch.data",
  "56f8efed1e7f2e5e21a7f78b1cb2df75860642667b145330b3a0ea196b2e3274",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
        categoric_indices=1:4,
    )
  end),
))
