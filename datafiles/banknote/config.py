#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('data_banknote_authentication.txt',
             'banknote.data',
             4,
             None,
             range(0, 4),
             [],
             ',',
             True)
