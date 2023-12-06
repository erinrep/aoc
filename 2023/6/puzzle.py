import re

print("Day 6: Wait For It")

with open("input.txt", encoding="utf-8") as f:
    [times, distances] = [re.findall(r"[0-9]+", l) for l in list(f)]

totals = []
for i, t in enumerate(times):
    winningHoldTimes = []
    for h in range(1, int(t) - 1):
        if (int(t) - h) * h > int(distances[i]):
            winningHoldTimes.append(h)
    totals.append(len(winningHoldTimes))

total = 1
for t in totals:
    total *= t

print("Part 1: ", total)

time = int("".join(times))
distance = int("".join(distances))
winners = 0
for h in range(1, time - 1):
    if (time - h) * h > distance:
        winners += 1

print("Part 2: ", winners)
