def pisarji(n, knjige):
    k = len(knjige)

    memo = [[float('inf')] + [0 for j in range(n)] for i in range(k + 1)]
    memo[0][0] = 0

    for st_pisarjev in range(1, n+1):
        for st_knjig in range(1,k+1):
            memo[st_knjig][st_pisarjev] =  min([max(sum(knjige[s-1:st_knjig]), memo[s-1][st_pisarjev-1]) for s in range(1, st_knjig + 1)])
    return memo[k][n]


print(pisarji(2, [10, 20, 50, 130, 120, 70, 20]))
print(pisarji(3, [10, 20, 50, 130, 120, 70, 20]))
print(pisarji(4, [10, 20, 50, 130, 120, 70, 20]))