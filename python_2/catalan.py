def catalan(n=float("inf")):
    i = 1
    memo = [1]

    if n > 0:
        yield 1

    while i < n:
        c = 0
        for j in range(i):
            c = c + memo[j] * memo[i-j-1]
        memo.append(c)
        yield c
        i = i + 1

g = catalan()
print([next(g) for i in range(15)])
