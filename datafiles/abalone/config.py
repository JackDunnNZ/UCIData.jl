#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('abalone.data.orig',
             'abalone.data',
             8,
             [],
             range(0, 8),
             range(0, 1),
             ',',
             True)
