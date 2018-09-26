using DataDeps

register(DataDep(
  "diabetes",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/diabetes.tar.gz",
  "1576fc343a2b726cce21484eed32c99e0a020d8e8c39b281ec2fab01b31786e1",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "Diabetes/diabetes.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=3,
        feature_indices=1:2,
    )
  end),
))
