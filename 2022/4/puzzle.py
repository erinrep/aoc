print("Day 4: Camp Cleanup")


def intersection(lst1, lst2):
    lst3 = [value for value in lst1 if value in lst2]
    return lst3


def list_from_range(r):
    start, end = r.split("-")
    return range(int(start), int(end) + 1)


with open("input.txt", encoding="utf-8") as f:
    assignments = [value.replace("\n", "") for value in list(f)]

part_one = 0
part_two = 0
for assignment in assignments:
    first, second = assignment.split(",")
    list1 = list_from_range(first)
    list2 = list_from_range(second)
    if all(item in list1 for item in list2) or all(item in list2 for item in list1):
        part_one += 1
    if intersection(list1, list2):
        part_two += 1

print("Part One: ", part_one)
print("Part Two: ", part_two)
