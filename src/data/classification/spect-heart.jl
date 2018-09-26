using DataDeps

register(DataDep(
  "spect-heart",
  "http://archive.ics.uci.edu/ml/datasets/SPECT+Heart",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/spect/SPECT.train",
  "0fd0258bfc8eb986623a45890676465ee92e738a95fdc01a6aef893d9c920115",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:23,
        categoric_indices=2:23,
    )
  end),
))
