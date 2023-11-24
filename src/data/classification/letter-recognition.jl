register(DataDep(
  "letter-recognition",
  "http://archive.ics.uci.edu/ml/datasets/Letter+Recognition",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/letter-recognition/letter-recognition.data",
  "2b89f3602cf768d3c8355267d2f13f2417809e101fc2b5ceee10db19a60de6e2",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:17,
    )
  end),
))
