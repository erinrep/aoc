print("Day 9: Mirage Maintenance")

with open("input.txt", encoding="utf-8") as f:
    histories = [[int(y) for y in x.replace("\n", "").split(" ")] for x in list(f)]


def nextLevel(level):
    nextLevel = []
    for i in range(len(level) - 1):
        nextLevel.append(level[i + 1] - level[i])
    return nextLevel


def makeLevels(level):
    levels = [level]
    while level.count(0) != len(level):
        levels.append(nextLevel(level))
        level = levels[-1]
    return levels


nums = []
for history in histories:
    levels = makeLevels(history)
    levels.reverse()
    prev = [0]
    for level in levels:
        level.append(level[-1] + prev[-1])
        prev = level
    nums.append(levels[-1][-1])

print("Part 1:", sum(nums))

nums = []
for history in histories:
    levels = makeLevels(history)
    levels.reverse()
    prev = [0]
    for level in levels:
        level.insert(0, level[0] - prev[0])
        prev = level
    nums.append(levels[-1][0])

print("Part 2:", sum(nums))
