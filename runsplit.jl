using ArgParse

include("split.jl")

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
  splitalldatasets(seed, train_size)
end

main()
