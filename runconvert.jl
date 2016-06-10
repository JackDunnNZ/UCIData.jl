using ArgParse

include("convert.jl")

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--normalize", "-n"
      help = "set if the data is to be normalized"
      action = :store_true
  end
  parsed_args = parse_args(s)
  normalize = parsed_args["normalize"]
  processalldirs(normalize)
end

main()
