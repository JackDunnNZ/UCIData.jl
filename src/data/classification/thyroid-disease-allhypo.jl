using DataDeps

register(DataDep(
  "thyroid-disease-allhypo",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/allhypo.data",
  "273bfa43c6ad226204cb42d17365143723786db447b074abb71a23a632c1ff53",
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
