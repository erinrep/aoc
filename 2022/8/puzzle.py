print("Day 8: Treetop Tree House")

def is_blocked(val, line):
  for x in line:
    if x >= val:
      return True
  return False

def get_scenic_score(val, line):
  score = 0
  for x in line:
    score += 1
    if x >= val:
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
    col = [grid[k][j] for k in range(len(grid))]
    up_blocked = is_blocked(val, (col[:i])[::-1])
    right_blocked = is_blocked(val, grid[i][j+1:])
    down_blocked = is_blocked(val, col[i+1:])
    left_blocked = is_blocked(val, (grid[i][:j])[::-1])
    if not up_blocked or not right_blocked or not down_blocked or not left_blocked:  
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
    col = [grid[k][j] for k in range(len(grid))]
    up = get_scenic_score(val, (col[:i])[::-1])
    right = get_scenic_score(val, grid[i][j+1:])
    down = get_scenic_score(val, col[i+1:])
    left = get_scenic_score(val, (grid[i][:j])[::-1])
    scores[i][j] = up * right * down * left

candidates = []
for i in range(len(scores)):
  candidates.append(max(scores[i]))

print("Part Two: ", max(candidates))