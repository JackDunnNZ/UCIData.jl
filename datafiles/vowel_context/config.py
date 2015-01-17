#!/usr/bin/python

import os
import sys

scriptpath = '../'
sys.path.append(os.path.abspath(scriptpath))

import convert

convert.main('vowel-context.data.orig',
             'vowel_context.data',
             13,
             [],
             range(3, 13),
             [],
             None,
             True)
