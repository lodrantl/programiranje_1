V, E = list(map(int, input().split(" ")))
CAL = int(input())

poti = []
for ss in c:
    line = ss.split(" ")
    a = int(line[0])
    a = int(line[1])
    a = int(line[2])
    poti.append((a,b,c))

memo = [-1 for i in range(V)]
memo[CAL] = 0

while True:
    did = False
    for do, od, dolzina in poti:
        if memo[od] != -1 and (memo[do] == -1 or memo[do]>memo[od]+dolzina):
            memo[do] = memo[od] + dolzina
            did = True
    if not did:
        break

for i in memo:
    print(i)

