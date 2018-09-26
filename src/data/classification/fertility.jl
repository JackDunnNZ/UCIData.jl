using DataDeps

register(DataDep(
  "fertility",
  "http://archive.ics.uci.edu/ml/datasets/Fertility",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00244/fertility_Diagnosis.txt",
  "c04c6f1a676fa6c55fa6c5ee23f9c9a4cada8e64419850767900380aec91cdbb",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=10,
        feature_indices=1:9,
        categoric_indices=[1; 6],
    )
  end),
))
