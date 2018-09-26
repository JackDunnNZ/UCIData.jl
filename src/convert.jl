function makeid(df::DataFrame, i::Int, id_indices)
  if isempty(id_indices)
    id = "id_$i"
  else
    id = join([df[i, j] for j in id_indices], "_")
  end
end

function process_dataset(
    path::String;
    target_index::Int=-1,
    feature_indices=1:0,
    id_indices=1:0,
    categoric_indices=1:0,
    kwargs...
  )

  df = readtable(
      path,
      header=false,
      nastrings=["", "NA", "?", "*", "#DIV/0!"],
      truestrings=["T", "t", "TRUE", "true", "y", "yes"],
      falsestrings=["F", "f", "FALSE", "false", "n", "no"];
      kwargs...
  )
  # df = CSV.read(
  #     path,
  #     header=false,
  #     delim=separator,
  #     missingstrings=["", "NA", "?", "*", "#DIV/0!"],
  #     truestrings=["T", "t", "TRUE", "true", "y", "yes"],
  #     falsestrings=["F", "f", "FALSE", "false", "n", "no"],
  #     skipto=header_lines
  # )

  output_names = Symbol[]
  output_df = DataFrame()

  output_df[:id] = [makeid(df, i, id_indices) for i in 1:size(df, 1)]
  push!(output_names, :id)

  # Construct output values
  categoric_indices_set = Set(categoric_indices)
  index = 2
  for i in feature_indices
    if i in categoric_indices_set
      push!(output_names, :C)
      # push!(output_names, Symbol("C$(length(output_names) - 1)"))
    else
      push!(output_names, :N)
      # push!(output_names, Symbol("N$(length(output_names) - 1)"))
    end
  end

  push!(output_names, :target)

  output_df = [output_df df[collect(feature_indices)] df[target_index]]
  names!(output_df, output_names, allow_duplicates=true)

  output_path = joinpath(dirname(path), "data.csv")
  writetable(output_path, output_df, separator=',', header=true)
end
