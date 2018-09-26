using DataDeps

register(DataDep(
  "tv-sales",
  "http://www.stat.ufl.edu/~winner/data/tvsales.txt",
  "http://www.stat.ufl.edu/~winner/data/tvsales.dat",
  "6d51cfd2b0eaed03f0bcb578f8a2b972227b83c33b6334ea47dbf2d3965aa87f",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=2,
        feature_indices=3:10,
        id_indices=1,
        separator=' ',
    )
  end),
))
