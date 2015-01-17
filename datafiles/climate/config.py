#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('pop_failures.dat',
             'climate.data',
             20,
             [0, 1],
             range(2, 20),
             [],
             None,
             True,
             True)
