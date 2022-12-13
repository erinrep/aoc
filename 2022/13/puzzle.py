import functools

print("Day 13: Distress Signal")

def compare(left, right):
  if isinstance(left, list) and isinstance(right, list):
    for i in range(len(left)):
      if i >= len(right):
        return 1
      x = compare(left[i], right[i])
      if x != 0:
        return x
    if len(left) == len(right):
      return 0
    return -1
  elif isinstance(left, list) and isinstance(right, int):
    return compare(left, [right])
  elif isinstance(left, int) and isinstance(right, list):
    return compare([left], right)
  else:
    if int(left) > int(right):
      return 1
    if int(left) < int(right):
      return -1
    if int(left) == int(right):
      return 0

with open('input.txt', encoding="utf-8") as f:
  raw_packets = [x.replace('\n', '') for x in list(f)]

packets = []
for i in range(0, len(raw_packets), 3):
  packets.append((eval(raw_packets[i]), eval(raw_packets[i+1])))

indices = []
for i in range(len(packets)):
  left, right = packets[i]
  if compare(left, right) == -1:
    indices.append(i+1)

print("Part One:", sum(indices))

packets = [[[2]],[[6]]]
for p in raw_packets:
  if p != "":
    packets.append(eval(p))

sorted_packets = sorted(packets, key=functools.cmp_to_key(compare))

total = 1
for i in range(len(sorted_packets)):
  if sorted_packets[i] == [[2]] or sorted_packets[i] == [[6]]:
    total *= (i + 1)

print("Part Two:", total)
