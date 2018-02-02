using ArgParse

include("convert.jl")

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--keepna"
      help = "optimal: whether to keep NAs or remove the rows. "
      action = :store_true
    "--keepcat", "-k"
      help = "optional: categorical coding C1, C2, etc.. Do not dummify. "
      action = :store_true
  end
  parsed_args = parse_args(s)
  keepna = parsed_args["keepna"]
  keepcat = parsed_args["keepcat"]

  processalldirs("classification", keepcat, keepna)
  processalldirs("regression", keepcat, keepna)
end

main()
