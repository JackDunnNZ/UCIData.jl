#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('CNAE-9.data',
             'cnae.data',
             0,
             [],
             range(1, 857),
             [],
             ',',
             True)
