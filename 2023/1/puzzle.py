import re


print("Day 1: Trebuchet?!")

with open("input.txt", encoding="utf-8") as f:
    lines = [x.replace("\n", "") for x in list(f)]

total = 0
for line in lines:
    calibration = list(re.sub(r"[a-z]", "", line))
    total += int(calibration[0] + calibration[-1])

print("Part 1:", total)

total = 0
nums = [
    "unused",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
]
for line in lines:
    for i in range(1, 10):
        line = line.replace(nums[i], f"{nums[i]}{i}{nums[i]}")
    calibration = list(re.sub(r"[a-z]", "", line))
    total += int(calibration[0] + calibration[-1])

print("Part 2:", total)
