using DataDeps

register(DataDep(
  "immigrant-salaries",
  "http://www.stat.ufl.edu/~winner/data/immwork.txt",
  "http://www.stat.ufl.edu/~winner/data/immwork.dat",
  "d4e517a5725a613bf30b224b53a5b3b4509cf7a126f7813a12b3d2769de6e470",
  post_fetch_method=(path -> begin
    # IDs have spaces in them which is the delimiter
    lines = readlines(path)
    map!(x -> lstrip(x[30:end]), lines, lines)
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:4,
        separator=' ',
    )
  end),
))
