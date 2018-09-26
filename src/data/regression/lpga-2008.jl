using DataDeps

register(DataDep(
  "lpga-2008",
  "http://www.stat.ufl.edu/~winner/data/lpga2008.txt",
  "http://www.stat.ufl.edu/~winner/data/lpga2008.dat",
  "3d631844fb4b13f7d1f9205005d5ef3687a383b515a39c027e41e5124883ed14",
  post_fetch_method=(path -> begin
    # IDs have spaces in them which is the delimiter
    lines = readlines(path)
    map!(x -> lstrip(x[30:end]), lines, lines)
    write(path, join(lines, '\n'))


    UCIData.process_dataset(path,
        target_index=8,
        feature_indices=1:6,
        id_indices=10,
        separator=' ',
    )
  end),
))
