using DataDeps

register(DataDep(
  "geographic-origin-music",
  "https://archive.ics.uci.edu/ml/datasets/Geographical+Original+of+Music",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00315/Geographical%20Original%20of%20Music.zip",
  "37bd14730ef7e4786e094421982ad32536298a9d84d875cd35d27423f14b409a",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "Geographical Original of Music/default_plus_chromatic_features_1059_tracks.txt")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=69,
        feature_indices=1:68,
    )
  end),
))
