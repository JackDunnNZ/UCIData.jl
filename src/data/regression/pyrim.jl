using DataDeps

register(DataDep(
  "pyrim",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/pyrim.tar.gz",
  "2e48b2a894a95883321bbeaa48effed1abfcd26a5060f330b288cff4b35e485a",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "pyrimidines/pyrim.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=28,
        feature_indices=1:27,
    )
  end),
))
