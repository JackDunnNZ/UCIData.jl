using DataDeps

register(DataDep(
  "blood-transfusion-service-center",
  "http://archive.ics.uci.edu/ml/datasets/Blood+Transfusion+Service+Center",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/blood-transfusion/transfusion.data",
  "96c8e1091b9c037bcaf25a19b24b49d07771cd88689ffd273e056e9e8845ffe7",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=5,
        feature_indices=1:4,
        skipstart=1,
    )
  end),
))
