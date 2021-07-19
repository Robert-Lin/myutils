import matplotlib.pyplot as plt
import numpy as np


def plotline(x, y, title="example title", xlabel="example xlabel", ylabel="example ylabel", show=True):
    plt.plot(x, y)
    if show:
        plt.grid(axis='y')
        plt.title(title)
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.show()

def plotlines(x, y, title="example title", xlabel="example xlabel", ylabel="example ylabel"):
    for l_y in y:
        plotline(x, l_y, title="example title",
                 xlabel="example xlabel", ylabel="example ylabel", show=False)
    plt.grid(axis='y')
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.show()

if __name__ == "__main__":
    x = [i for i in range(15)]
    y = [1.1819495713265062, 2.142736269614836, 1.6221231573941988, 3.4224341324471874, 2.1268822691668645, 2.78846309043437, 2.541096309043437, 2.2361980773795396, 2.8430269404225017, 4.402245134108711, 2.3277765250415383, 1.488458936624733, 2.242259969143128, 2.264251127462616, 1.2066161286494184]
    plotlines(x, y)

