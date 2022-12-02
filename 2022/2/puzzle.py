print("Day 1: Rock Paper Scissors")

with open('input.txt', encoding="utf-8") as f:
  strategy = list(f)

opponent_rock = 'A'
opponent_paper = 'B'
opponent_scissors = 'C'
self_rock = lose = 'X'
self_paper = draw = 'Y'
self_scissors = win = 'Z'
draw_score = 3
win_score = 6
rock_score = 1
paper_score = 2
scissors_score = 3

totalScore = 0

for r in range(len(strategy)):
  score = 0
  plays = strategy[r].replace('\n', '').split(" ")
  if (plays[0] == opponent_rock and plays[1] == self_rock) or (plays[0] == opponent_paper and plays[1] == self_paper) or (plays[0] == opponent_scissors and plays[1] == self_scissors):
    score += draw_score
  else:
    if (plays[0] == opponent_rock and plays[1] == self_paper) or (plays[0] == opponent_paper and plays[1] == self_scissors) or (plays[0] == opponent_scissors and plays[1] == self_rock):
      score += win_score

  if plays[1] == self_rock:
    score += rock_score
  elif plays[1] == self_paper:
    score += paper_score
  elif plays[1] == self_scissors:
    score += scissors_score

  totalScore += score

print("Part One: ", totalScore)

totalScore = 0
for r in range(len(strategy)):
  score = 0
  plays = strategy[r].replace('\n', '').split(" ")
  
  if plays[0] == opponent_rock:
    if plays[1] == lose:
      score += scissors_score
    elif plays[1] == draw:
      score += draw_score
      score += rock_score
    elif plays[1] == win:
      score += win_score
      score += paper_score
  elif plays[0] == opponent_paper:
    if plays[1] == lose:
      score += rock_score
    elif plays[1] == draw:
      score += draw_score
      score += paper_score
    elif plays[1] == win:
      score += win_score
      score += scissors_score
  elif plays[0] == opponent_scissors:
    if plays[1] == lose:
      score += paper_score
    elif plays[1] == draw:
      score += draw_score
      score += scissors_score
    elif plays[1] == win:
      score += win_score
      score += rock_score

  totalScore += score

print("Part 2: ", totalScore)