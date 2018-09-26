# UCIData.jl

This is a package for accessing [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets.html) datasets (and some from other sources) inside Julia. The UCI ML repository is a useful source for machine learning datasets for testing and benchmarking, but the format of datasets is not consistent. This means effort is required in order to make use of new datasets since they need to be read differently.

Instead, the aim is to convert the datasets into a common format (CSV), where each line is as follows:

    ID,attribute_1,attribute_2,...,attribute_n,class

The attribute header names start with `C` or `N`, indicating categoric or numeric variables.

These datasets can be accessed as `DataFrames` in Julia using the following, with categoric columns pooled into `PooledDataArray` type (here we load the "iris" dataset):

    using UCIData
    UCIData.dataset("iris")

You can get a list of dataset types with

    UCIData.list_dataset_types()

and then a list of the available datasets for a given type with

    UCIData.list_datasets("classification")

The datasets are not checked in to git in order to minimise the size of the repository and to avoid rehosting the data. As such, the script downloads any missing datasets directly from UCI as it runs, using [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl)

## Contributing

Please feel free to add new datasets via pull request!
