using ArgParse
using DataFrames
using MLBase

function splitDataset(dataset_path::String, train_path::String,
                      test_path::String, seed::Int, train_size::Int)
  df = readtable(dataset_path, header=false)
  n = size(df, 1)
  sn = iround(n * train_size / 100)

  srand(seed)
  train_inds = collect(RandomSub(n, sn, 1))[1]
  test_inds = setdiff(1:n, train_inds)

  dataset_name = basename(dataset_path)
  trainset_path = joinpath(train_path, dataset_name)
  testset_path = joinpath(test_path, dataset_name)

  writetable(trainset_path, df[train_inds, :], separator=',', header=false)
  writetable(testset_path, df[test_inds, :], separator=',', header=false)
end

function splitAllDatasets(seed::Int=0, train_size::Int=80)
  root_path = dirname(@__FILE__)
  processed_path = joinpath(root_path, "processed")

  for norm_dir in readdir(processed_path)
    normalize_path = joinpath(processed_path, norm_dir)
    if !isdir(normalize_path)
      continue
    end
    for class_dir in readdir(normalize_path)
      class_size_path = joinpath(normalize_path, class_dir)
      if !isdir(class_size_path)
        continue
      end

      # We have found a folder with datafiles
      target_path = joinpath(root_path, "split", norm_dir, class_dir)
      train_path = joinpath(target_path, "train")
      test_path = joinpath(target_path, "test")
      mkpath(train_path)
      mkpath(test_path)

      for dataset in readdir(class_size_path)
        dataset_path = joinpath(class_size_path, dataset)
        if !isfile(dataset_path)
          continue
        end
        splitDataset(dataset_path, train_path, test_path, seed, train_size)
      end
    end
  end
end

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--seed", "-s"
      help = "optional: specify a seed for the RNG"
      arg_type = Int
      default = 0
    "--train"
      help = "optional: percentage of data to include in training set"
      arg_type = Int
      default = 80
  end
  parsed_args = parse_args(s)
  seed = parsed_args["seed"]
  train_size = parsed_args["train"]
  splitAllDatasets(seed, train_size)
end

main()
