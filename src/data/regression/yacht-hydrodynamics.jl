using DataDeps

register(DataDep(
  "yacht-hydrodynamics",
  "https://archive.ics.uci.edu/ml/datasets/Yacht+Hydrodynamics",
  "https://archive.ics.uci.edu/ml/machine-learning-databases/00243/yacht_hydrodynamics.data",
  "00dfecc0fc01ddd4c90b558a3ac11b246df8ebcfea130724223475a9a67f0ea1",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=7,
        feature_indices=1:6,
        separator=' ',
    )
  end),
))
