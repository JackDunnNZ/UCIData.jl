using DataDeps

register(DataDep(
  "hybrid-price",
  "http://www.stat.ufl.edu/~winner/data/hybrid_reg.txt",
  "http://www.stat.ufl.edu/~winner/data/hybrid_reg.csv",
  "4c081c159b942b6c3e7b99f55047c03374a7c6833010b32a3508398cbe0b63d9",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=4,
        feature_indices=5:7,
        id_indices=2,
        skipstart=1,
    )
  end),
))
