using DataDeps

register(DataDep(
  "thyroid-disease-sick-euthyroid",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/sick-euthyroid.data",
  "6b93c0a10c6a1760d47864eb9f4592750cbfac389d9a64b9feec17f2690374c4",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:26,
        categoric_indices=[3:15; 17; 19; 21; 23; 25],
    )
  end),
))
