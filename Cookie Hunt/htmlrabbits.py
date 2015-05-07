#!/usr/bin/env/python3

''' Breed html pages '''

import argparse

parser = argparse.ArgumentParser(description='Breed html pages.')
parser.add_argument('integer', metavar='N', type=int, nargs='1',
                   help='number of html pages to create')

args = parser.parse_args()
print(args.accumulate(args.integers))