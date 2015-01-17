#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('mammographic_masses.data.orig',
             'mam.data',
             5,
             [],
             range(0, 5),
             [],
             ',',
             True)
