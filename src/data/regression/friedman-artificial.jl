using DataDeps

register(DataDep(
  "friedman-artificial",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/fried.tar.gz",
  "1a976d0dac0794595475719d308714b505226a72d2abe7499ca0a3f77fd5ecf8",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "FriedmanExample/fried_delve.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=1:10,
        separator=' ',
    )
  end),
))
