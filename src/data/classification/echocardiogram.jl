register(DataDep(
  "echocardiogram",
  "http://archive.ics.uci.edu/ml/datasets/Echocardiogram",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/echocardiogram/echocardiogram.data",
  "3d7dc4b3daef837f1b3b3c042e561697d6add718a2d6694de824faf1f1e340d4",
  post_fetch_method=(path -> begin
    # There is a misplaced leading comma on line 50, we should get rid of it
    lines = readlines(path)
    lines[50] = lines[50][2:end]
    write(path, join(lines, '\n'))

    UCIData.process_dataset(path,
        target_index=13,
        feature_indices=3:9,
    )
  end),
))
