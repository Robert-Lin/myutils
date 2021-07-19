import matplotlib.pyplot as plt


def plotbox(arr, title="example title", xlabel="example xlabel", ylabel="example ylabel"):
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.boxplot(arr)
    plt.show()

if __name__ == "__main__":
    plotbox([[1,2,3],[3,6,9]])
