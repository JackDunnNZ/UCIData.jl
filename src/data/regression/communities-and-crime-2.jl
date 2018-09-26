using DataDeps

register(DataDep(
  "communities-and-crime-2",
  "https://archive.ics.uci.edu/ml/datasets/Communities+and+Crime+Unnormalized",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00211/CommViolPredUnnormalizedData.txt",
  "383a9530b2802b4457986095b13af8f02a802a2504feaef45783f9c129e003f1",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=146,
        feature_indices=6:129,
        id_indices=1,
    )
  end),
))
