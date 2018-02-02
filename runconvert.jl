using ArgParse

include("convert.jl")

function main()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--normalize", "-n"
      help = "set if the data is to be normalized"
      action = :store_true
    "--keepna"
      help = "optimal: whether to keep NAs or remove the rows. "
      action = :store_true
    "--keepcat", "-k"
      help = "optional: categorical coding C1, C2, etc.. Do not dummify. "
      action = :store_true
    "--class_size", "-c"
      help = "optional: the number of classes to use in output datasets. " *
             "Leave as zero to include all classes. Applies to " *
             "classification only."
      arg_type = Int
      default = 0
    "--min_size", "-m"
      help = "optional: the minimum number of datapoints for each class. " *
             "If any class has fewer than this, no file will be created. " *
             "Applies to classification only."
      arg_type = Int
      default = 0

  end
  parsed_args = parse_args(s)
  normalize = parsed_args["normalize"]
  keepna = parsed_args["keepna"]
  keepcat = parsed_args["keepcat"]
  class_size = parsed_args["class_size"]
  min_size = parsed_args["min_size"]

  processalldirs("classification", normalize, keepcat, keepna, class_size, min_size)
  processalldirs("regression", normalize, keepcat, keepna)
end

main()
