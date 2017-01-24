memo = None

def st_s(n):
    global memo
    global stack
    memo = [-1 for i in range(n+4)]
    stack = 0
    memo[0] = 1
    memo[1] = 1
    memo[2] = 2
    memo[3] = 4

    s=st_stolpov(n)
    return s, stack

def st_s2(n):
    global memo
    global stack
    memo = [-1 for i in range(n+4)]
    stack = 0
    memo[0] = 1
    memo[1] = 1
    memo[2] = 2
    memo[3] = 4

    s=st_stolpov(n)
    return s, stack


def st_stolpov(n):
    global stack
    global memo

    if memo[n] != -1:
        return memo[n]
    stack += 1
    if (n % 2) == 0:
        l = n // 2
        s = st_stolpov(l)
        s1 = st_stolpov(l - 1)
        s2 = st_stolpov(l - 2)
        return s * s + s1 * s1 + 2 * s1 * s2
    else:
        l = n // 2
        s = st_stolpov(l)
        s1 = st_stolpov(l - 1)
        s2 = st_stolpov(l -2)
        sp1 = st_stolpov(l + 1)
        return s*sp1+s*s1+s1*s1+s*s2

def st_stolpov2(n):
    global stack
    global memo

    if memo[n] != -1:
        return memo[n]

    stack += 1

    return st_stolpov2(n-1) + st_stolpov2(n-2) + st_stolpov2(n-3)


x1 = []
y1 = []
x2 = []
y2 = []
for i in range(100):
    stack = 0
    s,n = st_s(i)
    s2,n2 = st_s2(i)
    if s != s2:
        print(i, s, s2)
    x1.append(i)
    x2.append(i)
    y1.append(n)
    y2.append(n2)


