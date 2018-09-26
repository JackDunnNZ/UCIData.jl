using DataDeps

register(DataDep(
  "trains",
  "http://archive.ics.uci.edu/ml/datasets/Trains",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/trains/trains-transformed.data",
  "d536c86b5d3b913e5a494dce1ea6f09a2b756b29831ce9156c02fe7ba25a556e",
  post_fetch_method=(path -> begin
    # The missing values are `-`. Replace with `?`
    write(path, replace(read(path, String), "-", "?"))

    UCIData.process_dataset(path,
        target_index=33,
        feature_indices=1:32,
        categoric_indices=[4:5; 7; 9:10; 12; 14:15; 17; 19:20; 22:32],
        separator=' ',
    )
  end),
))
