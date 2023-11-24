register(DataDep(
  "cpu-act",
  "https://www.openml.org/d/197",
  "https://www.openml.org/data/get_csv/3634/dataset_2183_cpu_act.arff",
  "316cdd36b28d1af79584b043b1ffc16bc492fe03f49b2d653eb09468f55392ed",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=22,
        feature_indices=1:21,
        header=true,
    )
  end),
))
