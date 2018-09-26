using DataDeps

register(DataDep(
  "connectionist-bench-sonar",
  "http://archive.ics.uci.edu/ml/datasets/Connectionist+Bench+%28Sonar%2C+Mines+vs.+Rocks%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/undocumented/connectionist-bench/sonar/sonar.all-data",
  "e90434cdbf00fcf93ffa911fe447ae25606979658e60f1d32e155c3b5240234d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=61,
        feature_indices=1:60,
    )
  end),
))
