using DataDeps

register(DataDep(
  "online-news-popularity",
  "https://archive.ics.uci.edu/ml/datasets/Online+News+Popularity",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00332/OnlineNewsPopularity.zip",
  "dba2ae526f62ccef6f2f8efb53b0268319f4d0d2719bb98d88958cfe31d58a22",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "OnlineNewsPopularity/OnlineNewsPopularity.csv")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=61,
        feature_indices=2:60,
        id_indices=1,
        skipto=2,
    )
  end),
))
