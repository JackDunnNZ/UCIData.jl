using DataDeps

register(DataDep(
  "climate-model-simulation-crashes",
  "http://archive.ics.uci.edu/ml/datasets/Climate+Model+Simulation+Crashes",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00252/pop_failures.dat",
  "8a892cbb056072e84749aed7409d6f17c7b4a1c899fc98ce52dc2af8b727ff9c",
  post_fetch_method=(path -> begin
    # The whitespace in this file is weird. Read/write to normalize whitespace
    writedlm(path, readdlm(path))

    UCIData.process_dataset(path,
        target_index=21,
        feature_indices=3:20,
        id_indices=1:2,
        separator='\t',
        skipstart=1,
    )
  end),
))
