print("Day 8: Treetop Tree House")

def check_blocked(grid, val, direction, static_coord, start, stop, step):
  for k in range(start, stop, step):
    if direction == "vert":
      if grid[k][static_coord] >= val:
        return True
    else:
      if grid[static_coord][k] >= val:
        return True
  return False

def get_scenic_score(grid, val, direction, static_coord, start, stop, step):
  score = 0
  for k in range(start, stop, step):
    score += 1
    if direction == "vert":
      if grid[k][static_coord] >= val:
        break
    else:
      if grid[static_coord][k] >= val:
        break
  return score

with open('input.txt', encoding="utf-8") as f:
  grid = [list(value.replace('\n', '')) for value in list(f)]

vis = []
for i in range(len(grid)):
  vis.append([])
  for j in range(len(grid)):
    if i == 0 or i == len(grid)-1 or j == 0 or j == len(grid)-1:
      vis[i].append("o")
    else:
      vis[i].append("x")

for i in range(1, len(grid)-1):
  for j in range(1, len(grid)-1):
    val = grid[i][j]
    up = check_blocked(grid, val, "vert", j, i-1, -1, -1)
    right = check_blocked(grid, val, "horz", i, j+1, len(grid[i]), 1)
    down = check_blocked(grid, val, "vert", j, i+1, len(grid[i]), 1)
    left = check_blocked(grid, val, "horz", i, j-1, -1, -1)
    if not up or not right or not down or not left:  
      vis[i][j] = 'o'

total = 0
for i in range(len(vis)):
  for j in range(len(vis[i])):
    if vis[i][j] == 'o':
      total += 1

print("Part One: ", total)


scores = []
for i in range(len(grid)):
  scores.append([])
  for j in range(len(grid)):
    scores[i].append(0)

for i in range(len(grid)):
  for j in range(len(grid)):
    val = grid[i][j]
    up = get_scenic_score(grid, val, "vert", j, i-1, -1, -1)
    right = get_scenic_score(grid, val, "horz", i, j+1, len(grid[i]), 1)
    down = get_scenic_score(grid, val, "vert", j, i+1, len(grid[i]), 1)
    left = get_scenic_score(grid, val, "horz", i, j-1, -1, -1)
    scores[i][j] = up * right * down * left

candidates = []
for i in range(len(scores)):
  candidates.append(max(scores[i]))

print("Part Two: ", max(candidates))