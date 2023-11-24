register(DataDep(
  "contraceptive-method-choice",
  "http://archive.ics.uci.edu/ml/datasets/Contraceptive+Method+Choice",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/cmc/cmc.data",
  "ad2a49da55df24b061a994ecc4d90c856aba35acd05138851aa251c4f06303c9",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=10,
        feature_indices=1:9,
        categoric_indices=7,
    )
  end),
))
