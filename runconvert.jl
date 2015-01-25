using ArgParse

include("convert.jl")

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--normalize", "-n"
      help = "set if the data is to be normalized"
      action = :store_true
    "--class_size", "-c"
      help = "optional: the number of classes to use in output datasets. " *
             "Leave as zero to include all classes."
      arg_type = Int
      default = 0
  end
  parsed_args = parse_args(s)
  normalize = parsed_args["normalize"]
  class_size = parsed_args["class_size"]
  processAllDirs(normalize, class_size)
end

main()
