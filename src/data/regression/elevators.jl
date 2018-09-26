using DataDeps

register(DataDep(
  "elevators",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/elevators.tgz",
  "a65edba13c25bc5e523ce42e7d087a8e9f0042a80ba2f16c6ed390a28b2c8090",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "Elevators/elevators.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=19,
        feature_indices=1:18,
    )
  end),
))
