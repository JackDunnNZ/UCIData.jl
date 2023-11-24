register(DataDep(
  "computer-hardware",
  "https://archive.ics.uci.edu/ml/datasets/Computer+Hardware",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/cpu-performance/machine.data",
  "c95f0e52fb8381a14a24aa7e9f4b50f72a08639ecfd8cc619ab779919dbd448b",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=10,
        feature_indices=[1; 3:9],
        id_indices=2,
        categoric_indices=1,
    )
  end),
))
