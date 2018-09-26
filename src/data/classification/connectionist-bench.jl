using DataDeps

register(DataDep(
  "connectionist-bench",
  "https://archive.ics.uci.edu/ml/datasets/Connectionist+Bench+(Vowel+Recognition+-+Deterding+Data)",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/undocumented/connectionist-bench/vowel/vowel-context.data",
  "1e5c40bdd0b6705c75586eb23f5d9c3078e9588f48bc5c2c98da219fe83fff29",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=14,
        feature_indices=4:13,
        separator=' ',
    )
  end),
))
