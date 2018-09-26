using DataDeps

register(DataDep(
  "kin8nm",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/kinematics.tar.gz",
  "d3edd5aaceaa6905a0c6251fcff63c48ca35479f34dff9bff238aa8e5f187ff0",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "Kinematics/kin8nm.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=1:8,
    )
  end),
))
