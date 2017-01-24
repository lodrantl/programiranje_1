def rabutanje(h, rastilne):
    n = len(rastilne)

    stevilo = [[0 for i in range(h+1)] for j in range(n+1)]

    for rastlin in range(1, n+1):
        r = rastilne[rastlin-1]
        for energija in range(1, h+1):
            stevilo[rastlin][energija] = max([stevilo[rastlin-1][energija-e]+s for s,e in enumerate([0] + r) if e <= energija])
    print(stevilo)
    return stevilo[n][h]

print(rabutanje(10, [[2, 5, 9], [5, 6, 7, 8], [1, 3, 6]]))