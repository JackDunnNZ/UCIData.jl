using DataDeps

register(DataDep(
  "mammographic-mass",
  "https://archive.ics.uci.edu/ml/datasets/Mammographic+Mass",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.data",
  "072051c896fb14f8f25c64eed30ba1333290af41e6c9ffad4e1ca573daa865a8",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=6,
        feature_indices=1:5,
        categoric_indices=3:4,
    )
  end),
))
