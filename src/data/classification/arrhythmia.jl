using DataDeps

register(DataDep(
  "arrhythmia",
  "http://archive.ics.uci.edu/ml/datasets/Arrhythmia",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/arrhythmia/arrhythmia.data",
  "a7f0f4ca289a4c58b5ed85a9adb793189acd38425828ce3dfbb70adb45f30169",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=280,
        feature_indices=1:279,
    )
  end),
))
