print("Day 6: Tuning Trouble")

def find_marker(l, size):
  for i in range(len(l)):
    if(len(set(l[i:i+size])) == size):
      break
  return i + size

with open('input.txt', encoding="utf-8") as f:
  signal = list(f.readline())

print("Part One: ", find_marker(signal, 4))
print("Part Two: ", find_marker(signal, 14))