using DataDeps

register(DataDep(
  "statlog-project-german-credit",
  "http://archive.ics.uci.edu/ml/datasets/Statlog+Project",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data",
  "b21f3d81db8071257d5ff1deaeba1fd4303b62712e6fcc9715c7a86202cb5871",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=21,
        feature_indices=1:20,
        categoric_indices=[1; 3:4; 6:7; 9:10; 12; 14:15; 17; 19:20],
        delim=' ',
    )
  end),
))
