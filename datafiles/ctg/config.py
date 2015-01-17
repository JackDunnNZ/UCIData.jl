#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('cardiotocography.data.orig',
             'cardio.data',
             22,
             None,
             range(0, 20),
             [],
             ',',
             True)
