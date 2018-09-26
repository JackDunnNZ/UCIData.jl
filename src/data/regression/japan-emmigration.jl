using DataDeps

register(DataDep(
  "japan-emmigration",
  "http://www.stat.ufl.edu/~winner/data/japanemg.txt",
  "http://www.stat.ufl.edu/~winner/data/japanemg.dat",
  "dc3f7d7cb5dec406251776b17208b1bee0db923203e1c30fc0547298f5559cb8",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=2,
        feature_indices=3:7,
        id_indices=1,
        separator=' ',
    )
  end),
))
