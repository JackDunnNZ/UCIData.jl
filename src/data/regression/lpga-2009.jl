using DataDeps

register(DataDep(
  "lpga-2009",
  "http://www.stat.ufl.edu/~winner/data/lpga2009.txt",
  "http://www.stat.ufl.edu/~winner/data/lpga2009.dat",
  "9f578d992e8e60a2727fe738bda266dfb0d518a0f13ba81d08bc79ad0fcd695d",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=8,
        feature_indices=[2:6; 9:14],
        id_indices=1,
        separator=' ',
    )
  end),
))
