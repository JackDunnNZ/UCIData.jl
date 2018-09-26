using DataDeps

register(DataDep(
  "ecoli",
  "http://archive.ics.uci.edu/ml/datasets/Ecoli",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/ecoli/ecoli.data",
  "008bd8fbb1d8b34040c3c8c4e987cac2a7ebf116e008b140cc6441be5261ba1d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=2:8,
        id_indices=1,
        separator=' ',
    )
  end),
))
