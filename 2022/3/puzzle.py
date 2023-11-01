print("Day 3: Rucksack Reorganization")


def intersection(lst1, lst2):
    lst3 = [value for value in lst1 if value in lst2]
    return lst3


def priority(c):
    if ord(c) >= ord("a"):
        return ord(c) - 96
    else:
        return ord(c) - 38


with open("input.txt", encoding="utf-8") as f:
    contents = [value.replace("\n", "") for value in list(f)]

total = 0
for items in contents:
    half = int(len(items) / 2)
    in_both = intersection(items[:half], items[half:])
    total += priority(in_both[0])

print("Part One: ", total)

groups = list()
group_size = 3
for i in range(0, len(contents), group_size):
    groups.append(contents[i : i + group_size])

total = 0
for g in groups:
    grp1, grp2, grp3 = g
    badge = intersection(intersection(grp1, grp2), grp3)
    total += priority(badge[0])

print("Part Two: ", total)
