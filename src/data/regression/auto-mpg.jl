using DataDeps

register(DataDep(
  "auto-mpg",
  "https://archive.ics.uci.edu/ml/datasets/Auto+MPG",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/auto-mpg.data",
  "48b830e11feee5572525f8f1691ddb9d38d3d7b7063edcd8fca672c2a5e17d8d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:8,
        id_indices=9,
        categoric_indices=8,
        separator=' ',
    )
  end),
))
