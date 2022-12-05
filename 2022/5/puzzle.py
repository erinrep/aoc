print("Day 5: Supply Stacks")

TARGET_INDEX = 3
COUNT_INDEX = 1
DESTINATION_INDEX = 5

def move_crates(rows, instructions, part_one):
  # transpose list of rows into columns
  transposed_tuples = list(zip(*rows))
  stacks = [list(sublist) for sublist in transposed_tuples]

  # remove placeholder empty items needed for transposing
  for i in range(len(stacks)):
    stacks[i] = [j for j in stacks[i] if j != '']

  # move items
  for i in range(len(instructions)):
    target = int(instructions[i][TARGET_INDEX])-1
    count = int(instructions[i][COUNT_INDEX])
    destination = int(instructions[i][DESTINATION_INDEX])-1
    moving = stacks[target][:count]
    if part_one:
      moving.reverse()
    del stacks[target][:count]
    stacks[destination] = moving + stacks[destination]

  return stacks  

def get_first_items(stacks):
  result = ""
  for i in range(len(stacks)):
    result += stacks[i][0].replace("[", "").replace("]", "")
  
  return result

with open('input.txt', encoding="utf-8") as f:
  supplies = [value.replace('\n', '') for value in list(f)]

rows = []
instructions = []
for i in range(len(supplies)):
  row = supplies[i].replace("    ", " ").split(" ")
  if row[0] == 'move':
    instructions.append(row)
  elif supplies[i] != '' and row[1] != '1':
    rows.append(row)

print("Part One: ", get_first_items(move_crates(rows, instructions, True)))
print("Part Two: ", get_first_items(move_crates(rows, instructions, False)))