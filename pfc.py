'''
Author       : Chuanqing Lin
Date         : 2020-12-11 15:11:53
LastEditTime : 2020-12-11 15:13:06
FilePath     : /myutils/pfc.py
Description  : 
'''
import numpy as np
import matplotlib.pyplot as plt

round = []
def split_round():
    data = [[] for i in range(15)]
    with open("fct_fat4_flow_reduce_dcqcn.txt", "r") as f:
        lines = f.read().splitlines()
        last = 0
        for line in lines:
            time = int(line.split(" ")[5])
            if time != last:
                last = time
                round.append(time)
        for i in range(len(lines)):
            line = lines[i]
            src, dst, sport, dport, size, start_time, duration, baseline = line.split(
                " ")
            time = float(duration) / 1000000  # ms
            data[i//16 % 15].append(time)
    return data

def find_round(time):
    '''
    the time in round #
    '''
    if time < round[0]:
        print("time error!\n")
    for i in range(len(round)):
        if time > round[i]:
            continue
        return i

if __name__ == "__main__":
    # data = split_round()
    # pfc_count = np.zeros(16,dtype=int)
    # with open("pfc_fat4_flow_reduce_dcqcn.txt", "r") as f:
    #     lines = f.read().splitlines()
    #     for line in lines:
    #         ts, receive_node, node_type, interface, is_pause = line.split(" ")
    #         if is_pause == "1":
    #             res = find_round(int(ts))
    #             if res < 16:
    #                 pfc_count[res] += 1

    # fig = plt.figure()
    # ax = fig.add_subplot(111)
    # ax.boxplot(data)
    # bx = ax.twinx()
    # bx.plot(pfc_count)
    
    # plt.grid(axis='y')
    # plt.title("job completion time and pfc count for each round (dcqcn)")
    # plt.xlabel("round")
    # ax.set_ylabel("ms")
    # bx.set_ylabel("times")
    # plt.show()
    pass

def analyze_pfc_location():
    '''
    res:
    dcqcn
    total:2402, core:135, agg:up779,down59, tor:up1429,down0
    hp95
    total:3119, core:226, agg:up1002,down99, tor:up1792,down0
    '''
    total = 0
    tor_up = 0
    tor_down = 0
    agg_up = 0
    agg_down = 0
    core = 0
    with open("pfc_fat4_flow_reduce_hp95.txt", "r") as f:
        lines = f.read().splitlines()
        for line in lines:
            ts, receive_node, node_type, interface, is_pause = line.split(" ")
            if is_pause == "0":
                continue
            total += 1
            if node_type == "0" and interface == "1":
                tor_up += 1
                continue
            n = int(receive_node)
            if n < 24 and n > 15:
                if int(interface) > 2:
                    agg_up += 1
                    continue
            if n > 23 and n < 32:
                if int(interface) > 2:
                    core += 1
                    continue
                else:
                    tor_down += 1
                    continue
            if n > 31:
                agg_down += 1
                continue
            print(line)

    print("total:%d, core:%d, agg:up%d,down%d, tor:up%d,down%d" % (total, core, agg_up, agg_down, tor_up, tor_down))

