#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('iris.data.orig',
             'iris.data',
             4,
             [],
             range(0, 4),
             [],
             ',',
             True)
