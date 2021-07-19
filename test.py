'''
Author       : Chuanqing Lin
Date         : 2020-12-29 15:46:54
LastEditTime : 2021-01-31 17:12:11
FilePath     : /myutils/test.py
Description  : 
'''
import random
import numpy as np

def round():
    path = [0 for i in range(5)]
    count = 0
    while 0 in path:
        count += 1
        choice = random.randint(0, 4)
        path[choice] = 1
    return count

if __name__ == "__main__":
    total = 0
    times = 100000
    for i in range(times):
        total += round()
    print(total / times)