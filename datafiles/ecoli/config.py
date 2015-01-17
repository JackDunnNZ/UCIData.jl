#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('ecoli.data.orig',
             'ecoli.data',
             8,
             [0],
             range(1, 8),
             [],
             None,
             True)
