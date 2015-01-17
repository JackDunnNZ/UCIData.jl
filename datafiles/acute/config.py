#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('diagnosis.data.orig',
             'acute.data.a',
             6,
             [],
             range(0, 6),
             range(1, 6),
             None,
             True)

convert.main('diagnosis.data.orig',
             'acute.data.b',
             7,
             [],
             range(0, 6),
             range(1, 6),
             None,
             True)
