register(DataDep(
  "blog-feedback",
  "https://archive.ics.uci.edu/ml/datasets/BlogFeedback",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00304/BlogFeedback.zip",
  "1ba74e5ad920f7cd037502b2968581cc695146a226a73eff52fe8ad875ed4bcf",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "blogData_train.csv")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=281,
        feature_indices=1:280,
        categoric_indices=63:262,
    )
  end),
))
