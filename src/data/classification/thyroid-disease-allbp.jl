using DataDeps

register(DataDep(
  "thyroid-disease-allbp",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/allbp.data",
  "2d2f9f2d956f70e013d673de6d662eae2f2097d100c1bcb5529925c1b9281d46",
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
