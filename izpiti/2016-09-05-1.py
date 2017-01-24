from bisect import *

def ljudozerci(ljud, padalci):
    m = len(padalci)
    n = len(ljud)

    for p in padalci:
        a = 0
        b = n - 1
        while a < b:
            c = (a+b) // 2
            if p < ljud[c]:
                b = c
            else:
                a = c + 1

        if (2* p - ljud[a] -ljud[a-1]) <= 0:
            ljud[a-1] = p
        else:
            ljud[a] = p

    return ljud

print(ljudozerci([1, 4, 4, 6, 10, 11, 15], [3, 5, 4, 8, 4, 14]))
