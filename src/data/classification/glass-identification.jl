using DataDeps

register(DataDep(
  "glass-identification",
  "http://archive.ics.uci.edu/ml/datasets/Glass+Identification",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/glass/glass.data",
  "dd67373f4baf2807345df02cbfef2093d342e61ad0d82a4fb79af43ef8ce449d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=2:10,
        id_indices=1,
    )
  end),
))
