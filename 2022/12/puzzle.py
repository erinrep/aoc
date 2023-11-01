print("Day 12: Hill Climbing Algorithm")


def valid_neighbor(elevations, curr, i, j):
    if i >= len(elevations) or i < 0:
        return False
    if j >= len(elevations[0]) or j < 0:
        return False
    next = elevations[i][j]
    if next == "E":
        next = "z"
    if next <= curr or ord(curr) + 1 == ord(next):
        return True


def bfs(graph, start, goal):
    explored = []
    queue = [[start]]

    while queue:
        path = queue.pop(0)
        node = path[-1]

        if node not in explored:
            neighbors = graph[node]

            for neighbor in neighbors:
                new_path = list(path)
                new_path.append(neighbor)
                queue.append(new_path)

                if neighbor == goal:
                    return new_path
            explored.append(node)
    return []


with open("input.txt", encoding="utf-8") as f:
    elevations = [list(x.replace("\n", "")) for x in list(f)]

start = ""
end = ""
starting_pts = []
for i in range(len(elevations)):
    for j in range(len(elevations[i])):
        pt = elevations[i][j]
        coords = f"{i},{j}"
        if pt == "S":
            start = coords
            starting_pts.append(coords)
            elevations[i][j] = "a"
        elif pt == "a":
            starting_pts.append(coords)
        elif pt == "E":
            end = coords

graph = {}
for i in range(len(elevations)):
    for j in range(len(elevations[i])):
        coords = f"{i},{j}"
        curr = elevations[i][j]
        neighbors = []
        if valid_neighbor(elevations, curr, i + 1, j):
            neighbors.append(f"{i+1},{j}")
        if valid_neighbor(elevations, curr, i - 1, j):
            neighbors.append(f"{i-1},{j}")
        if valid_neighbor(elevations, curr, i, j + 1):
            neighbors.append(f"{i},{j+1}")
        if valid_neighbor(elevations, curr, i, j - 1):
            neighbors.append(f"{i},{j-1}")
        graph[coords] = neighbors

path = bfs(graph, start, end)
print("Part One:", len(path) - 1)

print("slooooow...")
paths = []
for pt in starting_pts:
    l = len(bfs(graph, pt, end)) - 1
    if l != -1:
        paths.append(l)
print("Part Two:", min(paths))
