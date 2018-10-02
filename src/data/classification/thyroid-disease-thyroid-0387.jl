using DataDeps

register(DataDep(
  "thyroid-disease-thyroid-0387",
  "http://archive.ics.uci.edu/ml/datasets/Thyroid+Disease",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/thyroid-disease/thyroid0387.data",
  "4a20d104d4607afd7b1a477af5aa4381a2027f36cc7027f44bc2bd5a50c6724d",
  post_fetch_method=(path -> begin
    # The ids are appended to each row inside []. Replace with comma separation.
    write(path, replace(replace(read(path, String), "[" => ","), "]" => ""))

    UCIData.process_dataset(path,
        target_index=30,
        feature_indices=1:29,
        id_indices=31,
        categoric_indices=[2:17; 19; 21; 23; 25; 27; 29],
    )
  end),
))
