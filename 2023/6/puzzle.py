import re
from math import prod

print("Day 6: Wait For It")

with open("input.txt", encoding="utf-8") as f:
    [times, distances] = [re.findall(r"[0-9]+", l) for l in list(f)]

totals = []
for i, raceTime in enumerate(times):
    winningHoldTimes = 0
    for holdTime in range(1, int(raceTime) - 1):
        if (int(raceTime) - holdTime) * holdTime > int(distances[i]):
            winningHoldTimes += 1
    totals.append(winningHoldTimes)

print("Part 1:", prod(totals))

time = int("".join(times))
distance = int("".join(distances))
winners = 0
for h in range(1, time - 1):
    if (time - h) * h > distance:
        winners += 1

print("Part 2:", winners)
