#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun  8 19:48:25 2020

@author: em812
"""

from pathlib import Path

root = Path.home() / 'tierpsy_{{cookiecutter.project_name}}' / 'Results'

days = [item for item in root.glob('*/') if item.is_dir()]

with open('cmds2process.txt', "w") as fid:
    for day in days:
        fid.write('python calculate_feat_summaries.py {}'.format(day))
        fid.write('\n')
