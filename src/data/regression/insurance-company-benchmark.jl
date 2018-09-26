using DataDeps

register(DataDep(
  "insurance-company-benchmark",
  "https://archive.ics.uci.edu/ml/datasets/Insurance+Company+Benchmark+%28COIL+2000%29",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/tic-mld/ticdata2000.txt",
  "5d5bdca1be0b9a6c012b93a8c8104761201bd70f7e08764fa67f2cfb26243723",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=86,
        feature_indices=1:85,
        separator=' ',
    )
  end),
))
