using DataDeps

register(DataDep(
  "home-mortgage",
  "http://www.stat.ufl.edu/~winner/data/myield.txt",
  "http://www.stat.ufl.edu/~winner/data/myield.dat",
  "b2a3205acc023b99e2e76db74973209cf9dbbf0aef3f418a48b8fc8d3d6661df",
  post_fetch_method=(path -> begin
    # IDs have spaces in them which is the delimiter
    lines = readlines(path)
    map!(x -> lstrip(x[21:end]), lines, lines)
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=7,
        feature_indices=1:6,
        delim=' ',
        ignorerepeated=true,
    )
  end),
))
