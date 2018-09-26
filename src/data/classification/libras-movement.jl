using DataDeps

register(DataDep(
  "libras-movement",
  "http://archive.ics.uci.edu/ml/datasets/Libras+Movement",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/libras/movement_libras.data",
  "97ebdaa6a9b28ab4a2cdd84b14f19a95a7456a46137c362b65a0669eca3c3c4d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=91,
        feature_indices=1:90,
    )
  end),
))
