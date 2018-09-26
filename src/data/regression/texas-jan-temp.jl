using DataDeps

register(DataDep(
  "texas-jan-temp",
  "http://www.stat.ufl.edu/~winner/data/texas1.txt",
  "http://www.stat.ufl.edu/~winner/data/texas1.dat",
  "7592eb2896ee4b60151761706dc4e9264ccf7b902dbaa370f11fdfd16b316c04",
  post_fetch_method=(path -> begin
    # IDs have spaces in them which is the delimiter
    lines = readlines(path)
    map!(x -> lstrip(x[20:end]), lines, lines)
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:4,
        separator=' ',
    )
  end),
))
