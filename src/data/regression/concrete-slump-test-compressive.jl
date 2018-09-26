using DataDeps

register(DataDep(
  "concrete-slump-test-compressive",
  "https://archive.ics.uci.edu/ml/datasets/Concrete+Slump+Test",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/concrete/slump/slump_test.data",
  "78cea9fbb28ad8fc17f389e216e724dc04642c6c363143e67f6bcb97e74525ee",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=2:8,
        id_indices=1,
        skipstart=1,
    )
  end),
))
