import functools
import re

print("Day 7: Camel Cards")

with open("input.txt", encoding="utf-8") as f:
    lines = [x.replace("\n", "") for x in list(f)]

hands = []
for line in lines:
    info = line.split(" ")
    hands.append((info[0], int(info[1])))


def rankHand(hand):
    sortedHand = "".join(sorted(hand))
    # five of a kind
    if re.search(r"([AKQJT2-9])\1\1\1\1", sortedHand):
        return 7
    # four of a kind
    if re.search(r"([AKQJT2-9])\1\1\1", sortedHand):
        return 6
    # full house
    if re.search(r"([AKQJT2-9])\1\1([AKQJT2-9])\2", sortedHand) or re.search(
        r"([AKQJT2-9])\1([AKQJT2-9])\2\2", sortedHand
    ):
        return 5
    # three of a kind
    if re.search(r"([AKQJT2-9])\1\1", sortedHand):
        return 4
    # two pair
    elif re.search(r"([AKQJT2-9])\1.*([AKQJT2-9])\2", sortedHand):
        return 3
    # one pair
    elif re.search(r"([AKQJT2-9]).*\1", sortedHand):
        return 2
    # high card
    else:
        return 1


def compareCards(x, y):
    faceCards = {"A": 14, "K": 13, "Q": 12, "J": 11, "T": 10}
    if x in faceCards:
        numX = faceCards[x]
    else:
        numX = int(x)
    if y in faceCards:
        numY = faceCards[y]
    else:
        numY = int(y)

    if numX == numY:
        return 0
    if numX > numY:
        return 1
    else:
        return -1


def compareHands(x, y):
    rankedX = rankHand(x[0])
    rankedY = rankHand(y[0])
    if rankedX == rankedY:
        for i, card in enumerate(x[0]):
            cmp = compareCards(card, y[0][i])
            if cmp != 0:
                return cmp
    if rankedX > rankedY:
        return 1
    else:
        return -1


rankedHands = sorted(hands, key=functools.cmp_to_key(compareHands))
winnings = []
for i, hand in enumerate(rankedHands):
    winnings.append(hand[1] * (i + 1))

print("Part 1:", sum(winnings))
