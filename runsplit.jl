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
    "--stratified"
      help = "optional: set to use stratified sampling"
      action = :store_true
  end
  parsed_args = parse_args(s)
  seed = parsed_args["seed"]
  train_size = parsed_args["train"]
  stratified = parsed_args["stratified"]
  splitalldatasets(seed, train_size, stratified)
end

main()
