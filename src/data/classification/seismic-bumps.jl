using DataDeps

register(DataDep(
  "seismic-bumps",
  "https://archive.ics.uci.edu/ml/datasets/seismic-bumps",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00266/seismic-bumps.arff",
  "aabe512fab65b36d1dfb462650b75cfd8d99d8cc2723e8ecb4e6f5e1caccd5a7",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=19,
        feature_indices=1:18,
        categoric_indices=[1:3; 8],
        skipstart=154,
    )
  end),
))
