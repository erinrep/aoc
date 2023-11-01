def num_increases(nums):
    increased = 0
    for i in range(len(nums)):
        if i > 0 and int(nums[i]) > int(nums[i - 1]):
            increased += 1
    return increased


def part_two(nums):
    windows = []
    for i in range(len(nums)):
        if i < len(nums) - 2:
            windows.append(int(nums[i]) + int(nums[i + 1]) + int(nums[i + 2]))
    return num_increases(windows)


print("Day 1: Sonar Sweep")

with open("input.txt", encoding="utf-8") as f:
    depths = list(f)

print("Part One:", num_increases(depths))
print("Part Two:", part_two(depths))
