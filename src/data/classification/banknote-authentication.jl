register(DataDep(
  "banknote-authentication",
  "http://archive.ics.uci.edu/ml/datasets/banknote+authentication",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00267/data_banknote_authentication.txt",
  "d0539aaed2139ba7a587b3e34fb345ce503ff7d5d33dbf9912d8e195ce425cb9",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
    )
  end),
))
