using DataDeps

register(DataDep(
  "airfoil-self-noise",
  "https://archive.ics.uci.edu/ml/datasets/Airfoil+Self-Noise",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00291/airfoil_self_noise.dat",
  "74c75fd71783f1e6b71f8a622b993dc592897a97cd689c5090a07147a1b097b3",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=6,
        feature_indices=1:5,
        separator=' ',
    )
  end),
))
