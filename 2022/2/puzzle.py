print("Day 2: Rock Paper Scissors")

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
loss_score = 0

outcomes = {
  opponent_rock: {
    self_rock: draw_score,
    self_paper: win_score,
    self_scissors: loss_score
  },
  opponent_paper: {
    self_rock: loss_score,
    self_paper: draw_score,
    self_scissors: win_score
  },
  opponent_scissors: {
    self_rock: win_score,
    self_paper: loss_score,
    self_scissors: draw_score
  }
}
play_scores = {
  self_rock: 1,
  self_paper: 2,
  self_scissors: 3
}

totalScore = 0
for r in range(len(strategy)):
  [their_play, my_play] = strategy[r].replace('\n', '').split(" ")
  totalScore += outcomes[their_play][my_play]
  totalScore += play_scores[my_play]

print("Part One: ", totalScore)

what_to_play = {
  draw: {
    opponent_rock: self_rock,
    opponent_paper: self_paper,
    opponent_scissors: self_scissors 
  },
  win: {
    opponent_rock: self_paper,
    opponent_paper: self_scissors,
    opponent_scissors: self_rock
  },
  lose: {
    opponent_rock: self_scissors,
    opponent_paper: self_rock,
    opponent_scissors: self_paper
  }
}

totalScore = 0
for r in range(len(strategy)):
  [their_play, desired_outcome] = strategy[r].replace('\n', '').split(" ")
  my_play = what_to_play[desired_outcome][their_play]
  totalScore += outcomes[their_play][my_play]
  totalScore += play_scores[my_play]

print("Part Two: ", totalScore)