using DataDeps

register(DataDep(
  "triazines",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/triazines.tar.gz",
  "281c8390e2f976b307e66a3fc07b59a9d61d1a5b9e4758636b10f77eb583723e",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "triazines/triazines.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=61,
        feature_indices=1:60,
    )
  end),
))
