using DataDeps

register(DataDep(
  "kin8nm",
  "https://www.openml.org/d/189",
  "https://www.openml.org/data/get_csv/3626/dataset_2175_kin8nm.arff",
  "7b9bf0301ac936d88122557a151e1ba8f1ebc278fcf46d9f3c6d462debdbc8ad",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=1:8,
        header=true,
    )
  end),
))
