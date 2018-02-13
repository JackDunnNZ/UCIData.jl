using ArgParse

include("convert.jl")

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--categoric", "-c"
      help = "optional: keep categoric features as strings."
      action = :store_true
    "--missing", "-m"
      help = "optional: keep rows with missing values."
      action = :store_true
  end
  parsed_args = parse_args(s)
  keepcat = parsed_args["categoric"]
  keepna = parsed_args["missing"]

  processalldirs("classification", keepcat, keepna)
  processalldirs("regression", keepcat, keepna)
end

main()
