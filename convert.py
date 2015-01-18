#!/usr/bin/python

from ConfigParser import SafeConfigParser
from itertools import combinations

import os
import urllib

def convert_list(indices):
  return map(int, indices.split(',')) if indices else []

def process_dir(data_path, processed_path, normalise=True, class_size=0):
  config_path = os.path.join(data_path, 'config.ini')
  if not os.path.exists(config_path):
    return

  # Read config file
  parser = SafeConfigParser()
  parser.read(config_path)

  dataset_name = parser.get('info', 'name')
  dataset_data_url = parser.get('info', 'data_url')
  dataset_class_index = parser.getint('info', 'class_index')
  dataset_id_indices = parser.get('info', 'id_indices')
  dataset_value_indices = parser.get('info', 'value_indices')
  dataset_categoric_indices = parser.get('info', 'categoric_indices')
  dataset_separator = parser.get('info', 'separator')
  dataset_header_lines = parser.getint('info', 'header_lines')
  dataset_encoding = parser.get('info', 'encoding')

  dataset_id_indices = convert_list(dataset_id_indices)
  dataset_value_indices = convert_list(dataset_value_indices)
  dataset_categoric_indices = convert_list(dataset_categoric_indices)

  dataset_name_orig = '%s.orig' % dataset_name
  dataset_path = os.path.join(data_path, dataset_name_orig)

  # Download the dataset if we don't have it already
  if not os.path.exists(dataset_path):
    urllib.urlretrieve(dataset_data_url, dataset_path)

  # Read dataset file
  f_in = open(dataset_path, 'rU')
  lines = f_in.read().decode(dataset_encoding)
  lines = [line for line in lines.splitlines() if line]
  # Skip specified number of header lines
  lines = lines[dataset_header_lines:]
  f_in.close()

  classes = {}
  class_count = 0

  categoric_classes = [{} for _ in dataset_value_indices]
  categoric_counts = [0 for _ in dataset_value_indices]
  categoric_set = frozenset(dataset_categoric_indices)

  max_val = [-1e10] * len(lines[0])
  min_val = [1e10] * len(lines[0])

  row_values = []
  row_classes = []
  row_ids = []

  missing_rows = set()

  for i, line in enumerate(lines):
    if dataset_separator:
      lines[i] = line.split(dataset_separator)
    else:
      lines[i] = line.split()

    # Count and number the classes
    row_class = lines[i][dataset_class_index]
    if row_class not in classes:
      classes[row_class] = class_count
      class_count += 1
    row_classes.append(classes[row_class])

    # Construct id for each row
    if dataset_id_indices:
      row_id = '_'.join([lines[i][j] for j in dataset_id_indices])
    else:
      row_id = str(i + 1)
    row_ids.append('id_%s' % row_id)

    # Process values
    v = []
    for j in dataset_value_indices:
      if lines[i][j] == '?':
        missing_rows.add(i)
        continue
      v.append(lines[i][j])

    for j, val in enumerate(v):
      # Count categoric values
      if dataset_value_indices[j] in categoric_set:
        if val not in categoric_classes[j]:
          categoric_classes[j][val] = categoric_counts[j]
          categoric_counts[j] += 1
      # Find min/max for numeric values
      else:
        # Catch error when number is formatted with ',' as decimal separator
        try:
          val = float(val)
        except:
          val = float(val.replace(',', '.'))
          lines[i][dataset_value_indices[j]] = val
        index = dataset_value_indices[j]
        if max_val[index] < val:
          max_val[index] = val
        if min_val[index] > val:
          min_val[index] = val

  # Class size zero means include all classes in one file
  num_classes = class_count if class_size == 0 else class_size

  if num_classes > class_count:
    # There are too few classes in this dataset to process the correct number
    # We exit instead
    return

  for i, line in enumerate(lines):
    # Skip missing data rows
    if i in missing_rows:
      row_values.append([])
      continue

    new_values = []
    for j in dataset_value_indices:
      # Convert n categorical to n-1 dummy vars
      if j in dataset_categoric_indices:
        # Construct array of n-1 zeros
        categoric = [0] * (categoric_counts[j] - 1)
        # Find the index, i, of the current categoric value, and set the (i-1)th
        # entry of the array to 1. We treat the 1st categoric value as the zero
        # vector.
        cur_index = categoric_classes[j][line[j]] - 1
        if cur_index >= 0:
          categoric[cur_index] = 1
        new_values += categoric

      else:
        if normalise:
          new_values.append(str((float(line[j]) - min_val[j]) /
                                float(max_val[j]  - min_val[j])))
        else:
          new_values.append(line[j])
    row_values.append(new_values)

  # Create an output file handle for every combination of classes we want
  f = []
  sorted_classes = sorted(classes.values())
  for comb in combinations(sorted_classes, num_classes):
    comb_name = 'all' if class_size == 0 else '.'.join(map(str, comb))
    outname = '%s.%s' % (dataset_name, comb_name)
    f.append(open(os.path.join(processed_path, outname), 'w'))

  for i, line in enumerate(lines):
    # Skip missing row
    if i in missing_rows:
      continue

    # Create output row
    row_class = row_classes[i]
    row_id = row_ids[i]
    out_string = ','.join([row_id] + map(str, row_values[i])) + ','

    # Output to the files for which this is part of the combination
    for k, comb in enumerate(combinations(sorted_classes, num_classes)):
      if row_class in comb:
        row_class_new = comb.index(row_class)
        f[k].write(out_string + str(row_class_new) + '\n')

  for f_out in f:
    f_out.close()


def main(normalise=False, class_size=0):

  root_path = os.path.dirname(__file__)
  datafiles_path = os.path.join(root_path, 'datafiles')

  class_size_name = 'all' if class_size == 0 else str(class_size)
  processed_path = os.path.abspath(os.path.join(root_path, 'processed',
                                                class_size_name))
  if not os.path.exists(processed_path):
    os.makedirs(processed_path)

  # Process everything in datafiles folder
  for dir in os.listdir(datafiles_path):
    data_path = os.path.join(datafiles_path, dir)
    # Skip any paths that aren't folders
    if not os.path.isdir(data_path):
      continue
    print 'Processing %s' % dir
    process_dir(data_path, processed_path, normalise, class_size)

if __name__ == '__main__':
  import argparse

  parser = argparse.ArgumentParser(description='Process datafiles.')
  parser.add_argument('-n', '--normalise', action='store_true')
  parser.add_argument('-c', '--classes', type=int, default=0)

  args = parser.parse_args()
  normalise = args.normalise
  class_size = args.classes

  main(normalise, class_size)
