register(DataDep(
  "credit-approval",
  "http://archive.ics.uci.edu/ml/datasets/Credit+Approval",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/credit-screening/crx.data",
  "fff49bc186cbddb3ace7371d40d9fbbb3af4f126019c13ff3f562249b1454f4d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=16,
        feature_indices=1:15,
        categoric_indices=[1; 4:7; 9:10; 12:13],
    )
  end),
))
