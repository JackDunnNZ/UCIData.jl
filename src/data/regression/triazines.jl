using DataDeps

register(DataDep(
  "triazines",
  "https://www.openml.org/d/206",
  "https://www.openml.org/data/get_csv/3643/dataset_2192_triazines.arff",
  "f6cf2b6604df302c869691b5e41cc2df010b051ac9f414d541f12958dd382ef1",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=61,
        feature_indices=1:60,
        header=true,
    )
  end),
))
