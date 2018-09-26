using DataDeps

register(DataDep(
  "hayes-roth",
  "http://archive.ics.uci.edu/ml/datasets/Hayes-Roth",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/hayes-roth/hayes-roth.data",
  "7d7ca47e6d9076863fef2810c80a44a28fe7beffbc17473d4a4948100cffb2dc",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=6,
        feature_indices=2:5,
        id_indices=1,
    )
  end),
))
