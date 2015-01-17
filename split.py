#!/usr/bin/python

import argparse
import random
import os

parser = argparse.ArgumentParser()
parser.add_argument('filename')
parser.add_argument('-s', '--seed', default=0, type=int)
parser.add_argument('--train', default=80, type=int)

args = parser.parse_args()

with open(args.filename, 'rU') as f:
  lines = f.readlines()

n = len(lines)

new_order = range(n)
random.seed(args.seed)
random.shuffle(new_order)

train_start = 0
test_start = train_start + int(float(args.train) / 100 * n)

basename = os.path.basename(args.filename)

f_train = open(os.path.join('split_data', 'train', basename), 'w')
f_test = open(os.path.join('split_data', 'test', basename), 'w')

for i in range(train_start, test_start):
  f_train.write(lines[new_order[i]])

for i in range(test_start, n):
  f_test.write(lines[new_order[i]])

f_train.close()
f_test.close()

###
# Analyse train set for eps in each dimension
###

train_path = os.path.join('split_data', 'train', basename)
with open(train_path, 'rU') as f:
  lines = f.readlines()

# Load values from training set back in
p = len(lines[0].split(',')) - 2
x = [[] for _ in range(p)]
for line in lines:
  values = line.split(',')[1:-1]
  for j, val in enumerate(values):
    x[j].append(float(val))

# Find min diff in each dimension
min_diffs = []
for i in range(p):
  values = sorted(x[i])
  min_diff = 1  # The largest diff we can get is 1
  for j in range(len(values) - 1):
    diff = float(values[j + 1]) - float(values[j])
    if diff != 0 and diff < min_diff:
      min_diff = diff
  min_diffs.append(str(min_diff))

# Rewrite training set with eps prepended
with open(train_path, 'w') as f:
  f.write('eps,' + ','.join(min_diffs) + ',\n')
  for line in lines:
    f.write(line)
