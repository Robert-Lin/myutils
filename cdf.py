import numpy as np
import matplotlib.pyplot as plt

filename = ""
'''
example cdf
0     0
10000 0.15
20000 0.2
30000 0.3
50000 0.4
80000 0.53
200000 0.6
1000000 0.7
2000000 0.8
5000000 0.9
10000000 0.97
30000000 1
'''
def plotcdf(arr, title="example title", xlabel="example xlabel", ylabel="example ylabel"):
    hist, bin_edges = np.histogram(arr,2000)
    cdf = np.cumsum(hist)/len(arr)
    plt.grid(axis='y')
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    # plt.xlim(-10,5)
    plt.plot(bin_edges[:-1],cdf)

    plt.show()


def plotcdfs(num=1, arr=[[]], legend=[""], title="example title", xlabel="example xlabel", ylabel="example ylabel"):
    plt.grid(axis='y')
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    for i in range(num):
        hist, bin_edges = np.histogram(arr[i], 2000)
        cdf = np.cumsum(hist)/len(arr[i])
        plt.plot(bin_edges[:-1], cdf, label=legend[i])
        plt.legend()
    plt.show()

def plot2(arr):
    '''
    need to modify, not working now
    '''
    plt.hist(arr.sort(), bins=2000, normed=True, cumulative=True, label='CDF', histtype='step', color='k')
    plt.show()

if __name__ == "__main__":
    arr = np.random.normal(size=10000)-1
    arr2 = np.random.normal(size = 100000)
    a = [arr, arr2]
    plotcdfs(2,a,["1","2"])

