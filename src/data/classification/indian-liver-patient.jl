using DataDeps

register(DataDep(
  "indian-liver-patient",
  "http://archive.ics.uci.edu/ml/datasets/ILPD+%28Indian+Liver+Patient+Dataset%29",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/00225/Indian%20Liver%20Patient%20Dataset%20(ILPD).csv",
  "84feac16488de5cf89bd22bd802c77f25841fe93e9ddd32355683e94d46c3425",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=11,
        feature_indices=1:10,
        categoric_indices=2,
    )
  end),
))
