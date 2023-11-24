register(DataDep(
  "shuttle-landing-control",
  "http://archive.ics.uci.edu/ml/datasets/Shuttle+Landing+Control",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/shuttle-landing-control/shuttle-landing-control.data",
  "a93ffca47434936a33e227ce3f268eaab54794dc0303d08fb8fc3856c5e7174f",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:7,
        categoric_indices=2:7,
    )
  end),
))
