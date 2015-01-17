#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('onehr.data.orig',
             'onehr.data',
             73,
             [],
             range(1, 73),
             [],
             ',',
             True)
