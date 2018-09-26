using DataDeps

register(DataDep(
  "optical-recognition-handwritten-digits",
  "http://archive.ics.uci.edu/ml/datasets/Optical+Recognition+of+Handwritten+Digits",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/optdigits/optdigits.tra",
  "e1b683cc211604fe8fd8c4417e6a69f31380e0c61d4af22e93cc21e9257ffedd",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=65,
        feature_indices=1:64,
    )
  end),
))
