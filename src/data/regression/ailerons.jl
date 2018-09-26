using DataDeps

register(DataDep(
  "ailerons",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/ailerons.tgz",
  "2eb15628e03b0686cb84d199570f5caa9a01755136d87d0002f805dde8464c71",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "Ailerons/ailerons.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=41,
        feature_indices=1:40,
    )
  end),
))
