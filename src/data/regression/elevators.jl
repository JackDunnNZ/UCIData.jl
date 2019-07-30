using DataDeps

register(DataDep(
  "elevators",
  "https://www.openml.org/d/216",
  "https://www.openml.org/data/get_csv/3653/dataset_2202_elevators.arff",
  "6c80dc6d2e78b42693ecff38ac42062774a5294cfa1f22e509601ae72f7a6af4",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=19,
        feature_indices=1:18,
        header=true,
    )
  end),
))
