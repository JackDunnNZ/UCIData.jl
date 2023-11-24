register(DataDep(
  "congressional-voting-records",
  "http://archive.ics.uci.edu/ml/datasets/Congressional+Voting+Records",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/voting-records/house-votes-84.data",
  "c87c14110a5ba91d4a1e313ec7392824458152bf071fa5f5452340488337936e",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:17,
        categoric_indices=2:17,
    )
  end),
))
