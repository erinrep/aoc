print("Day 7: No Space Left On Device")

with open('input.txt', encoding="utf-8") as f:
  commands = [value.replace('\n', '') for value in list(f)]

dirs = {}
breadcrumbs = []

for i in range(len(commands)):
  command = commands[i].split(" ")
  if command[0] == "$" and command[1] == "cd":
    arg = command[2]
    full_path = arg
    if len(breadcrumbs) > 0:
      full_path = '-'.join(breadcrumbs) + "-" + arg
    if arg == "..":
      breadcrumbs.pop()
    elif not full_path in dirs.keys():
      dirs[full_path] = []
      breadcrumbs.append(arg)
  elif command[0] == "$" and command[1] == "ls":
    for j in range(i + 1, len(commands)):
      if commands[j][0] != "$":
        dirs['-'.join(breadcrumbs)].append(commands[j])
      else:
        break

sizes = {}
# get file sizes
for key in dirs:
  for i in range(len(dirs[key])):
    parts = dirs[key][i].split(" ")
    if not key in sizes.keys():
      sizes[key] = 0
    if parts[0] != "dir":
      sizes[key] += int(parts[0])

# add dir sizes
paths = list(dirs.keys())
paths.reverse()
for key in paths:
  for i in range(len(dirs[key])):
    parts = dirs[key][i].split(" ")
    if parts[0] == "dir":
      sizes[key] += sizes[key + "-" + parts[1]]

total = 0
for key in sizes:
  if sizes[key] <= 100000:
    total += sizes[key]

print("Part One: ", total)

total = sizes["/"]
needed = 70000000 - total
candidates = []
for key in sizes:
  if sizes[key] >= 30000000 - needed:
    candidates.append(sizes[key])

print("Part Two: ", min(candidates))