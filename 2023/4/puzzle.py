import re

print("Day 4: Scratchcards")

with open("input.txt", encoding="utf-8") as f:
    lines = [x.replace("\n", "").replace("  ", " ").split(" | ") for x in list(f)]

total = 0
for line in lines:
    winningNums = line[0].split(": ")[1].split(" ")
    nums = line[1].split(" ")
    cardValue = 0
    for n in nums:
        if n in winningNums:
            if cardValue == 0:
                cardValue = 1
            else:
                cardValue = cardValue * 2
    total += cardValue


print("Part 1: ", total)

cards = []
for line in lines:
    winningNums = line[0].split(": ")[1].split(" ")
    nums = line[1].split(" ")
    matchingNums = 0
    for n in nums:
        if n in winningNums:
            matchingNums += 1
    cards.append(
        {
            "winningNums": winningNums,
            "nums": nums,
            "matchingNums": matchingNums,
            "copies": 1,
        }
    )

for i, card in enumerate(cards):
    for j in range(card["matchingNums"]):
        cards[i + j + 1]["copies"] += card["copies"]

total = 0
for c in cards:
    total += c["copies"]

print("Part 2: ", total)
