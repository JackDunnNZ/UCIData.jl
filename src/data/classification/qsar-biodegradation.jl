using DataDeps

register(DataDep(
  "qsar-biodegradation",
  "http://archive.ics.uci.edu/ml/datasets/QSAR+biodegradation",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00254/biodeg.csv",
  "c66ac1a23aba11fb166fd5054fea14ac97b8e4f7e4940ae679dc863d1cc4b3c9",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=42,
        feature_indices=1:41,
        separator=';',
    )
  end),
))
