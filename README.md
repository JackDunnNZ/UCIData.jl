# UCI ML Repository conversion script

This is a script for converting [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets.html) datasets (and some from other sources) into a common format. The UCI ML repository is a useful source for machine learning datasets for testing and benchmarking, but the format of datasets is not consistent. This means effort is required in order to make use of new datasets since they need to be read differently.

Instead, the aim is to convert the datasets into a common format (CSV), where each line is as follows:

    ID,attribute_1,attribute_2,...,attribute_n,class

These datasets can then be read using DataFrames in Julia using:

    df = readtable(dataset, header=false)

This makes it easy to switch out datasets in ML problems, which is great when automating things!

## Converting to common format

The datasets are not checked in to git in order to minimise the size of the repository and to avoid rehosting the data. As such, the script downloads any missing datasets directly from UCI as it runs.

### Running the script

#### Command line

Use the following command from the root folder:

    julia runconvert.jl

This processes all data folders in the `datafiles` folder. The output directory is the `processed` folder.

It is possible to normalize the data to [0, 1], and/or to limit the number of classes in the output files (for classification only).

    usage: runconvert.jl [-n] [-c CLASS_SIZE] [-m MIN_SIZE] [-h]

    optional arguments:
      -n, --normalize       set if the data is to be normalized
      -c, --class_size CLASS_SIZE
                            optional: the number of classes to use in
                            output datasets. Leave as zero to include all
                            classes. Applies to classification only.
                            (type: Int64, default: 0)
      -m, --min_size MIN_SIZE
                            optional: the minimum number of datapoints for
                            each class. If any class has fewer than this,
                            no file will be created. Applies to
                            classification only. (type: Int64, default: 0)

For example, if you wanted to normalize the data and were working with a binary classifier (and thus need two classes) you would run `julia convert.jl -n -c 2`

If `class_size` is set to `1`, then the behavior is slightly different. One file will be output for each class in the dataset, in which the respective class will take value `1` while all other classes take value `0`. These output files are then suited for the task of distinguishing a single class from all others.

`min_size` when set ensures that no output files are created where any class has fewer than this number of observations. For example, setting this to 10 will ensure that each class present in the output files has more than 10 observations.

## Guide to config files

Due to the varying nature of the datasets in the repository, the script needs to behave differently for different datasets. This is achieved using the `config.ini` files present in each dataset folder. An example of this file is:

    [info]
    name = mammographic-mass.data
    info_url = https://archive.ics.uci.edu/ml/datasets/Mammographic+Mass
    data_url = https://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.data
    target_index = 6
    id_indices =
    value_indices = 1,2,3,4,5
    categoric_indices = 3,4
    separator = comma
    header_lines = 0

A guide to each of the attributes follows.

##### [info]

This is an arbitrary choice for describing the data in the config file. It must be included at the start of each file but otherwise doesn't matter.

##### name

The name of the dataset that will be produced by the script. The convention used is the name of the dataset on the UCI info page, converted to lower case with spaces replaced with hyphens. The suffix `.data` is then added. This name (before adding `.data`) is also used for the name of the containing folder.

##### info_url

Contains the link to the UCI information page for the dataset, allowing the dataset to be traced back to its source.

##### data_url

Contains the link to the dataset itself on UCI. To avoid checking in the datasets to Github, the script instead downloads any missing datafiles using these links when it runs.

##### target_index

A single integer indicating the index (1-based) of the variable in the dataset we want to predict.

##### id_indices

Any number of integers (separated by commas and no spaces i.e. 1,2,3) that indicate the indices (1-based) of any id values present in the dataset. These will be combined to form the final id value used in the output. If no id information is present in the dataset, leave this blank and the id value will be generated automatically.

##### value_indices

One or more integers (separated by commas and no spaces i.e. 1,2,3) that indicate the indices (1-based) of the data values in the dataset.

##### categoric_indices

A subset of the integers specified in `value_indices` that indicate those data values that are categorical/nominal in nature.

##### separator

The separator between values in the dataset. If this is left blank, the input dataset is broken on all whitespace. Due to limitations in `ConfParser.jl`, for a comma you need to use `comma` rather than just `,`.

##### header_lines

An integer number of header lines in the dataset before the values are reached.

## Contributing

Please feel free to add new datasets via pull request!
