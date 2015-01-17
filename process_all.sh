#!/bin/bash

# Cleanup old files
rm cleaned_data/*
rm split_data/test/*
rm split_data/train/*

# Process each folder in data
cd data
find . -type d -exec bash -c "cd '{}' && ./config.py && cd .." \;
cd ..

# Convert data sets into training, validation and test
for filename in cleaned_data/*; do
  python data/split.py "$filename"
done

