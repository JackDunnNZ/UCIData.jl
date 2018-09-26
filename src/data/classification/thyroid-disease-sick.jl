using DataDeps

register(DataDep(
  "thyroid-disease-sick",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/sick.data",
  "81d4e8ae85233d453afc3ac721cfc5af8d83c0e8cd39d70aa9923089022f2c02",
  post_fetch_method=(path -> begin
    # The ids are appended to each row after `.|`. Replace with comma
    write(path, replace(read(path, String), ".|", ","))

    UCIData.process_dataset(path,
        target_index=30,
        feature_indices=1:29,
        id_indices=31,
        categoric_indices=[2:17; 19; 21; 23; 25; 27; 29],
    )
  end),
))
