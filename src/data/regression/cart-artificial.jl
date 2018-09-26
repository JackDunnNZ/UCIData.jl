using DataDeps

register(DataDep(
  "cart-artificial",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/DataSets.html",
  "http://www.dcc.fc.up.pt/~ltorgo/Regression/cart.tar.gz",
  "770d0f41cb1fd7bcac867950474a8ed88810cc046fbdc83422d767e65172a29e",
  post_fetch_method=(path -> begin
    unpack(path)
    new_path = joinpath(dirname(path), "CartExample/cart_delve.data")
    mv(new_path, path)

    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=1:10,
        separator=' ',
    )
  end),
))
