from functools import reduce
from operator import mul, add
import copy

print("Day 11: Monkey in the Middle")

with open("input.txt", encoding="utf-8") as f:
    notes = [x.replace("\n", "") for x in list(f)]

operations = {"+": add, "*": mul}


def play_round(monkeys, part):
    stress_reducer = 3
    if part == 2:
        stress_reducer = reduce(mul, (m["test"]["val"] for m in monkeys))
    for monkey in monkeys:
        while len(monkey["items"]) > 0:
            item = monkey["items"].pop()
            str_val = monkey["operation"]["val"]
            val = 0
            if str_val == "old":
                val = item
            else:
                val = int(str_val)
            worry = operations[monkey["operation"]["action"]](item, val)
            if part == 1:
                worry = int(worry / stress_reducer)
            else:
                worry = worry % stress_reducer
            index = monkey["test"]["false"]
            if worry % monkey["test"]["val"] == 0:
                index = monkey["test"]["true"]
            monkeys[index]["items"].append(worry)
            monkey["num_inspections"] += 1


def calc_monkey_business(monkeys):
    inspections = []
    for m in monkeys:
        inspections.append(m["num_inspections"])
    inspections.sort()
    inspections.reverse()
    return inspections[0] * inspections[1]


def part_one(monkeys):
    for i in range(20):
        play_round(monkeys, 1)
    return calc_monkey_business(monkeys)


def part_two(monkeys):
    for i in range(10000):
        play_round(monkeys, 2)
    return calc_monkey_business(monkeys)


monkeys = []
for i in range(len(notes)):
    line = notes[i]
    if len(line) == 0:
        continue
    if line[0] == "M":
        items = notes[i + 1].split(": ")[1].split(", ")
        operation = notes[i + 2].split("old ")[1].split(" ")
        test = notes[i + 3].split("by ")
        if_true = notes[i + 4].split("monkey ")
        if_false = notes[i + 5].split("monkey ")
        monkey = {
            "items": [int(x) for x in items],
            "operation": {"action": operation[0], "val": operation[1]},
            "test": {
                "val": int(test[1]),
                "true": int(if_true[1]),
                "false": int(if_false[1]),
            },
            "num_inspections": 0,
        }
        monkeys.append(monkey)

m2 = copy.deepcopy(monkeys)
print("Part One:", part_one(monkeys))
print("Part Two:", part_two(m2))
