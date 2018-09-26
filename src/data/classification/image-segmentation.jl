using DataDeps

register(DataDep(
  "image-segmentation",
  "http://archive.ics.uci.edu/ml/datasets/Image+Segmentation",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/image/segmentation.data",
  "ed5b5aee8081bbe875357149f73f50d7085e22cc0897f5b52eb7b52fea969a5b",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:20,
        skipstart=5,
    )
  end),
))
