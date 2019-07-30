using DataDeps

register(DataDep(
  "pyrim",
  "https://www.openml.org/d/217",
  "https://www.openml.org/data/get_csv/3654/dataset_2203_pyrim.arff",
  "a2625a60c6a144ddcf2334df9e2f8cd087f7e95908be3b167e17d3c9587282b3",
  post_fetch_method=(path -> begin
    UCIData.process_dataset(path,
        target_index=28,
        feature_indices=1:27,
        header=true,
    )
  end),
))
