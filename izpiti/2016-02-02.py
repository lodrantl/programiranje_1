def naloga2a(zap):
    st = dict()
    for x in zap: #O(n) časovna zahtevnost
        st[x] = st.get(x,0) + 1

        st[x] = st[x] + st.get(x-1, 0) + st.get(x+1,0)

    return sum(st.values())

print(naloga2a([1,2,3,1]))

def naloga2b(zap):
    st = dict()
    for x in zap: #O(n) * notranjost
        if x not in st:
            st[x] = set() #O(1)

        st[x].add((x,))

        for z in st.get(x-1,set()): #O(2^n)
            st[x].add(z + (x,))

        for z in st.get(x + 1, set()):
            st[x].add(z + (x,))


def naloga2c(zap):
    n = len(zap)
    if n == 0:
        return 0

    m = 1
    curr = 1
    z = zap[0]

    for i in range(1, len(zap)):

        x = zap[i]
        y = zap[i-1]
        if abs(x-y) == 1:
            curr += 1
        else:
            if x == z:
                m = curr
            curr = 0

    return max(m, curr)


def naloga2c2(zap):
    if not zap:
        return 0

    naj = 1  # Dolžina najdaljšega, ki smo ga odkrili do sedaj.
    zacetek = {zap[0]: 0}  # zacetek[x] je indeks prve pojavitve elementa x v trenutnem drobencljavem zaporedju.

    n = len(zap)
    for i in range(1, n):
        x = zap[i]
        if abs(x - zap[i - 1]) != 1:
            # Zaporedje je prekinjeno, začeti je treba znova.
            zacetek.clear()
            zacetek[x] = i
        else:
            # Saga se nadaljuje.
            if x not in zacetek:
                # Število x se pojavi prvič.
                zacetek[x] = i
            else:
                # Število se ne pojavi prvič.
                dolzina = i - zacetek[x] + 1
                naj = max(dolzina, naj)

    return naj


print(naloga2c([1, 2, 3, 2, 4, 3, 1]))
print(naloga2c2([1, 2, 3, 2, 4, 3, 1]))


