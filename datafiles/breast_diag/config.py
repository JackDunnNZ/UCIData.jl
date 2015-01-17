#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('wdbc.data',
             'breast_diag.data',
             1,
             [0],
             range(2, 31),
             [],
             ',',
             True)
