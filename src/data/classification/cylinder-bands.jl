using DataDeps

register(DataDep(
  "cylinder-bands",
  "http://archive.ics.uci.edu/ml/datasets/Cylinder+Bands",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/cylinder-bands/bands.data",
  "31b4bd7f6cbca567e06199ae8bbe085c00d64657fcb2daad0c214cb4d08076f7",
  post_fetch_method=(path -> begin
    # There is a misplaced line break on line 522, we should get rid of it
    lines = readlines(path)
    lines[522] *= lines[523]
    deleteat!(lines, 523)
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=40,
        feature_indices=1:39,
        categoric_indices=2:20,
    )
  end),
))
