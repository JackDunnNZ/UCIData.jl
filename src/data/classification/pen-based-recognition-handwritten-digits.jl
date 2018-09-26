using DataDeps

register(DataDep(
  "pen-based-recognition-handwritten-digits",
  "http://archive.ics.uci.edu/ml/datasets/Pen-Based+Recognition+of+Handwritten+Digits",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/pendigits/pendigits.tra",
  "e2b9eb9f0d0467e2b64a4816a3420edf2b8043447576f4b84337aba44a9f97d3",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=17,
        feature_indices=1:16,
    )
  end),
))
