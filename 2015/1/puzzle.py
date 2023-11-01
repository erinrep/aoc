print("Day 1: Not Quite Lisp")

GO_UP = "("

with open('input.txt', encoding="utf-8") as f:
  directions = list(f.read())

floor = 0
for d in directions:
    if d == GO_UP:
        floor += 1
    else:
        floor -= 1

print("Part 1: ", floor)

floor = 0
for idx, d in enumerate(directions):
    if d == GO_UP:
        floor += 1
    else:
        floor -= 1
    if floor == -1:
        print("Part 2: ", idx + 1)
        break