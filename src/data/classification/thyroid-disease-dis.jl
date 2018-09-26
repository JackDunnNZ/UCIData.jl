using DataDeps

register(DataDep(
  "thyroid-disease-dis",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/dis.data",
  "a3bd9146673142d1f0cf0322b2a9d4a933015b99e7194512a98e24c1c8ac56c4",
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
