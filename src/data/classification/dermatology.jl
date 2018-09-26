using DataDeps

register(DataDep(
  "dermatology",
  "http://archive.ics.uci.edu/ml/datasets/Dermatology",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/dermatology/dermatology.data",
  "455eba77f72cd087ce54a5a266c514c5f34e85000c8689ad09e796d68ad45742",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=35,
        feature_indices=1:34,
    )
  end),
))
