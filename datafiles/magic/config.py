#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('magic04.data.orig',
             'magic04.data',
             10,
             [],
             range(0, 10),
             [],
             ',',
             True)
