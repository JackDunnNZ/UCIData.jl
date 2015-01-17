#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('breast-cancer-wisconsin.data.orig',
             'breast_orig.data',
             10,
             [0],
             range(1, 10),
             [],
             ',',
             True)
