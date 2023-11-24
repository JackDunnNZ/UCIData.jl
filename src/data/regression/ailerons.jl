register(DataDep(
  "ailerons",
  "https://www.openml.org/d/296",
  "https://www.openml.org/data/get_csv/52060/ailerons.arff",
  "a866e46f5f5d34cd10583ef366bcc183f04cafda773fa55619d17fd9d70dd68d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=41,
        feature_indices=1:40,
        header=true,
    )
  end),
))
