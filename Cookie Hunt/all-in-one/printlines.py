#!/usr/bin/python3

fp = open('index.html', 'r')
for line in fp:
    print(len(line))
