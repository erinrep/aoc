print("Day 1: Calorie Counting")

with open('input.txt', encoding="utf-8") as f:
  snacks = list(f)

calories = [0]
i = 0
for j in range(len(snacks)):
  if snacks[j] == '\n':
    i += 1
    calories.append(0)
  else:
    calories[i] += int(snacks[j])

print("Part 1: ", max(calories))

NUM_ELVES = 3
total = 0
for i in range(NUM_ELVES):
  total += int(calories.pop(calories.index(max(calories))))

print("Part 2: ", total)
