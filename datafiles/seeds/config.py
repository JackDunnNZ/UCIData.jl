#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('seeds.data.orig',
             'seeds.data',
             7,
             [],
             range(0, 7),
             [],
             None,
             True)
