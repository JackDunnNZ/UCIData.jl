using DataDeps

register(DataDep(
  "construction-maintenance",
  "http://www.stat.ufl.edu/~winner/data/const_maint.txt",
  "http://www.stat.ufl.edu/~winner/data/const_maint.dat",
  "31fe1ce069e1b50c0fabb0e19270df58ecfaed0cf37be74b26a42251000c6c84",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=2,
        feature_indices=3:6,
        id_indices=1,
        separator=' ',
    )
  end),
))
