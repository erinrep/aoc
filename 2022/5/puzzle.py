print("Day 5: Supply Stacks")

TARGET_INDEX = 3
COUNT_INDEX = 1
DESTINATION_INDEX = 5


def get_stacks_from_rows(rows):
    transposed_tuples = list(zip(*rows))
    stacks = [list(sublist) for sublist in transposed_tuples]

    # remove placeholder empty items needed for transposing
    for i in range(len(stacks)):
        stacks[i] = [j for j in stacks[i] if j != ""]

    return stacks


def move_crates(stacks, instructions, part_one):
    for instruction in instructions:
        target = int(instruction[TARGET_INDEX]) - 1
        count = int(instruction[COUNT_INDEX])
        destination = int(instruction[DESTINATION_INDEX]) - 1
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


with open("input.txt", encoding="utf-8") as f:
    supplies = [value.replace("\n", "") for value in list(f)]

rows = []
instructions = []
for supply in supplies:
    # leave empty items in list for later transposing
    row = supply.replace("    ", " ").split(" ")
    if row[0] == "move":
        instructions.append(row)
    elif supply != "" and row[1] != "1":
        rows.append(row)

print(
    "Part One: ",
    get_first_items(move_crates(get_stacks_from_rows(rows), instructions, True)),
)
print(
    "Part Two: ",
    get_first_items(move_crates(get_stacks_from_rows(rows), instructions, False)),
)
