register(DataDep(
  "planning-relax",
  "http://archive.ics.uci.edu/ml/datasets/Planning+Relax",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00230/plrx.txt",
  "88d6db30747ae5090525ecbb512eb32f552eafb9e78b180ca0dfa37667e93c74",
  post_fetch_method=(path -> begin
    # First char of each row is whitespace, remove
    write(path, join(strip.(readlines(path)), "\n"))

    UCIData.process_dataset(path,
        target_index=13,
        feature_indices=1:12,
        delim=' ',
        ignorerepeated=true,
    )
  end),
))
