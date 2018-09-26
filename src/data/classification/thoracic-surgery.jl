using DataDeps

register(DataDep(
  "thoracic-surgery",
  "http://archive.ics.uci.edu/ml/datasets/Thoracic+Surgery+Data",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00277/ThoraricSurgery.arff",
  "a92b446b681138619ac3e210d5641744fe77b039c2b7219456a21533e36f3015",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=17,
        feature_indices=1:16,
        categoric_indices=[1; 4:15],
        skipstart=21,
    )
  end),
))
