#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('eighthr.data.orig',
             'eighthr.data',
             73,
             [],
             range(1, 73),
             [],
             ',',
             True)
