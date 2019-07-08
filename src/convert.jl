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
  df = CSV.File(
      path,
      header=false,
      typemap=Dict(Date=>String, DateTime=>String),
      missingstrings=["", "NA", "?", "*", "#DIV/0!"],
      truestrings=["T", "t", "TRUE", "true", "y", "yes"],
      falsestrings=["F", "f", "FALSE", "false", "n", "no"];
      kwargs...
  ) |> DataFrame

  output_names = Symbol[]
  output_df = DataFrame()

  output_df[:id] = [makeid(df, i, id_indices) for i in 1:size(df, 1)]
  push!(output_names, :id)

  # Construct output values
  categoric_indices_set = Set(categoric_indices)
  for i in feature_indices
    if i in categoric_indices_set
      push!(output_names, :C)
    else
      push!(output_names, :N)
    end
    output_df[size(output_df, 2) + 1] = df[i]
  end
  names!(output_df, output_names, makeunique=true)

  output_df[:target] = df[target_index]

  output_path = joinpath(dirname(path), "data.csv")

  CSV.write(output_path, output_df, delim=',', writeheader=true)
end
