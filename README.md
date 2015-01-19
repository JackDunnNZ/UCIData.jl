# UCI ML Repository conversion script

This is a script for converting UCI Machine Learning Repository data into a common format. The UCI ML repository is a useful source for machine learning datasets for testing and benchmarking, but the format of datasets is not consistent. This means effort is required in order to make use of new datasets since they need to be read differently.

Instead, the aim is to convert the datasets into a common format (CSV), where each line is as follows:

    ID,attribute_1,attribute_2,...,attribute_n,class
    
## Overview of script

A number of features are present:

- The datasets are not checked in to git in order to minimise the size of the repository and to avoid rehosting the data. As such, the script downloads any missing datasets directly from UCI as it runs.
- Real, integer, ordinal, and categorical/nominal values are supported. Categorical measurements will be broken into dummy binary measurements in accordance with best practice.
- Optionally, the data values can be normalised to a 0-1 range.
- Optionally, the dataset can be broken into a number of output files with different class combinations. For example, if you are working with a binary classifier, the output files should contain two classes only. The script can output a separate dataset for each pairwise combination of classes in the original dataset.

## Running the script

Use the following command from the root folder:
  
    python convert.py
    
Additional options are available:

    usage: convert.py [-n] [-c CLASSES]
    
- add the `-n` flag to normalise the data values
- add the `-c` flag followed by an integer to limit the number of classes in the output. For instance, you would use `python convert.py -c 2` if working with a binary classifier.
    
## Guide to config files

Due to the varying nature of the datasets in the repository, the script needs to behave differently for different datasets. This is achieved using the `config.ini` files present in each dataset folder. An example of this file is:

    [info]
    name = mammographic-mass.data
    info_url = https://archive.ics.uci.edu/ml/datasets/Mammographic+Mass
    data_url = https://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.data
    class_index = 5
    id_indices =
    value_indices = 0,1,2,3,4
    categoric_indices = 2,3
    separator = ,
    header_lines = 0
    encoding = ascii

A guide to each of the attributes follows.

##### [info]

This is an arbitrary choice for describing the data in the config file. It must be included at the start of each file but otherwise doesn't matter.

##### name

The name of the dataset that will be produced by the script. The convention used is the name of the dataset on the UCI info page, converted to lower case with spaces replaced with hyphens. The suffix `.data` is then added. This name (before adding `.data`) is also used for the name of the containing folder.

##### info_url

Contains the link to the UCI information page for the dataset, allowing for the dataset to be traced back to its source.

##### data_url

Contains the link to the dataset itself on UCI. To avoid checking in the datasets to Github, the script instead downloads any missing datafiles using these links when it runs.

##### class_index

A single integer indicating the index (0-based) of the class variable in the dataset (what we want to predict).

##### id_indices

Any number of integers (separated by commas and no spaces i.e. 1,2,3) that indicate the indices (0-based) of any id values present in the dataset. These will be combined to form the final id value used in the output. If no id information is present in the dataset, leave this blank and the id value will be generated automatically.

##### value_indices

One or more integers (separated by commas and no spaces i.e. 1,2,3) that indicate the indices (0-based) of the data values in the dataset.

##### categoric_indices

A subset of the integers specified in `value_indices` that indicate those data values that are categorical/nominal in nature.

##### separator

The separator between values in the dataset. If this is left blank, the input dataset is broken on all whitespace.

##### header_lines

An integer number of header lines in the dataset before the values are reached.

##### encoding

The encoding of the dataset as a string. Must match a [supported Python 2 codec](https://docs.python.org/2/library/codecs.html#standard-encodings). Usually `ascii` will be sufficient.

## TODO

- Fix up `split.py` for splitting data into training/testing sets.
- Add more datasets!

## Contributing

Please feel free to add new datasets via pull request!
