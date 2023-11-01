print("Day 3: Perfectly Spherical Houses in a Vacuum")

with open("input.txt", encoding="utf-8") as f:
  directions = list(f.read())

def move(d, x, y):
  match d:
    case ">":
      x += 1
    case "<":
      x -= 1
    case "v":
      y -= 1
    case "^":
      y += 1
  return (x, y)

x = 0
y = 0
houses = {"0,0"}
for d in directions:
  x, y = move(d, x, y)
  houses.add(f"{x},{y}")

print("Part 1: ", len(houses))

x = 0
y = 0
rx = 0
ry = 0
houses = {"0,0"}
for idx, d in enumerate(directions):
  if (idx % 2) == 0:
    x, y = move(d, x, y)
    houses.add(f"{x},{y}")
  else:
    rx, ry = move(d, rx, ry)
    houses.add(f"{rx},{ry}")

print("Part 2: ", len(houses))
