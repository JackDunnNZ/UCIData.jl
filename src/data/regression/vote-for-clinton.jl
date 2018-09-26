using DataDeps

register(DataDep(
  "vote-for-clinton",
  "http://www.stat.ufl.edu/~winner/data/clinton1.txt",
  "http://www.stat.ufl.edu/~winner/data/clinton1.dat",
  "51ae0be6fbf96ce4f9b36684a036c6e6c144549bb673ccd4ff045696ed6d9382",
  post_fetch_method=(path -> begin
    # IDs have spaces in them which is the delimiter
    lines = readlines(path)
    map!(x -> lstrip(x[30:end]), lines, lines)
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=1,
        feature_indices=2:10,
        separator=' ',
    )
  end),
))
