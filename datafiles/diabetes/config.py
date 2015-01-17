#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('pima-indians-diabetes.data.orig',
             'diabetes.data',
             8,
             [],
             range(0, 8),
             [],
             ',',
             True)
