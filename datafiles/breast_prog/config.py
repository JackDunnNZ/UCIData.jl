#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('wpbc.data',
             'breast_prog.data',
             1,
             [0],
             range(3, 34),
             [],
             ',',
             True)
