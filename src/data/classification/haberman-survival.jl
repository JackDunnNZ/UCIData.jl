register(DataDep(
  "haberman-survival",
  "http://archive.ics.uci.edu/ml/datasets/Haberman%27s+Survival",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/haberman/haberman.data",
  "b4b7a32586a5668f9f4d6dc8be9d1bc8cd4822523affb1f6b5bfc350681ef3e2",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=4,
        feature_indices=1:3,
    )
  end),
))
