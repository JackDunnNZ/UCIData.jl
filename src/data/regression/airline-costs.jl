using DataDeps

register(DataDep(
  "airline-costs",
  "http://www.stat.ufl.edu/~winner/data/airline_costs.txt",
  "http://www.stat.ufl.edu/~winner/data/airline_costs.dat",
  "fe2dc4189dc58761370d2cfa7fb0358a96b1164871167703085e6dddd0d91b1d",
  post_fetch_method=(path -> begin
    # IDs have spaces in them which is the delimiter
    lines = readlines(path)
    map!(x -> lstrip(x[25:end]), lines, lines)
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=6,
        feature_indices=[2:5; 7:11],
        separator=' ',
    )
  end),
))
