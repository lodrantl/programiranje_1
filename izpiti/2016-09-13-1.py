import numpy as np

def strizenje(babnice, konec):
    zacetek = babnice[0]
    cas = konec - zacetek
    n = len(babnice)
    max = cas / n


    for i in range(1, n+1):
        max_i = (konec-babnice[n-i]) / i
        if max > max_i:
            max = max_i
    return max

def je_mogoce(t, Z, T):
    konec = float('-inf')
    for x in t:
        zacetek = max(x, konec)
        konec = zacetek + T
        # print(round(konec, 4))
    return konec <= Z

def strizenje2(t, Z):
    a = 0
    b = Z - t[-1]
    while b - a > 10**-10:
        c = (a + b) / 2
        if je_mogoce(t, Z, c):
            a = c
        else:
            b = c
    return a


for i in range(10):
    test_array = sorted(50 * np.random.rand(1,40)[0])
    end = test_array[-1] + (np.random.rand() * 10)
    print(strizenje(test_array, end))
    print(strizenje2(test_array, end))


print(strizenje([0.1, 2.5, 6.2, 8.0, 10.0, 13.0], 16.0))
print(strizenje2([0.1, 2.5, 6.2, 8.0, 10.0, 13.0], 16.0))
