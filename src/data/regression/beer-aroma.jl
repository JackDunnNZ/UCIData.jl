using DataDeps

register(DataDep(
  "beer-aroma",
  "http://www.stat.ufl.edu/~winner/data/aroma_beer.txt",
  "http://www.stat.ufl.edu/~winner/data/aroma_beer.dat",
  "eaf147c291030154be364fe408dc0d01bac0407482eb91e965aca111abc0b977",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=9,
        feature_indices=2:8,
        id_indices=1,
        separator=' ',
    )
  end),
))
