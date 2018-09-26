using DataDeps

register(DataDep(
  "yeast",
  "http://archive.ics.uci.edu/ml/datasets/Yeast",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/yeast/yeast.data",
  "7cf61776fc04f527f93bf57a327b863893a1225d82df02d457e8950173218258",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=10,
        feature_indices=2:9,
        id_indices=1,
        separator=' ',
    )
  end),
))
