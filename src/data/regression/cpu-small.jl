register(DataDep(
  "cpu-small",
  "https://www.openml.org/d/227",
  "https://www.openml.org/data/get_csv/3664/dataset_2213_cpu_small.arff",
  "5183289a479c5f2effbdfb1a221964bab6510ccd1d8e4264b48a15b3807611ae",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=13,
        feature_indices=1:12,
        header=true,
    )
  end),
))
