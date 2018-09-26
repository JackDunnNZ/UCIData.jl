using DataDeps

register(DataDep(
  "cnae-9",
  "http://archive.ics.uci.edu/ml/datasets/CNAE-9",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00233/CNAE-9.data",
  "fec557bade36db8d35b29596d73eab7fd88c26f75f0ba07ee69636614c5d6055",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:857,
    )
  end),
))
