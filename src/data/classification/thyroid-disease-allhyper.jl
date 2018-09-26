using DataDeps

register(DataDep(
  "thyroid-disease-allhyper",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/allhyper.data",
  "0f51a31e457233ce24b38a8ee4f47089a240e76af547eaa8595461be98e36f75",
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
