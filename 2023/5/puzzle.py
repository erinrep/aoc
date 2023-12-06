print("Day 5: If You Give A Seed A Fertilizer")

with open("input.txt", encoding="utf-8") as f:
    lines = f.read().split("\n\n")

seeds = [int(x) for x in lines.pop(0).split(": ")[1].split(" ")]
maps = []
for line in lines:
    info = line.split(":\n")
    ranges = []
    for m in info[1].split("\n"):
        nums = [int(n) for n in m.split(" ")]
        destRange = range(nums[0], nums[0] + nums[2])
        sourceRange = range(nums[1], nums[1] + nums[2])
        ranges.append({"sourceRange": sourceRange, "destRange": destRange})
    maps.append(ranges)

locations = []
for seed in seeds:
    x = seed
    for map in maps:
        for ranges in map:
            try:
                pos = ranges["sourceRange"].index(x)
                x = ranges["destRange"][pos]
                break
            except:
                continue
    locations.append(x)

print("Part 1:", min(locations))


seedRanges = []
for i in range(0, len(seeds), 2):
    seedRanges.append(range(seeds[i], seeds[i] + seeds[i + 1]))


def mapRange(ranges, map):
    allTheRanges = []
    for rng in ranges:
        mappedRanges = []
        for r in map:
            # range is outside of source range
            if rng.start < r["sourceRange"].start and rng.stop < r["sourceRange"].start:
                continue
            if rng.start > r["sourceRange"].stop and rng.stop > r["sourceRange"].stop:
                continue

            # range contains source range
            if rng.start < r["sourceRange"].start and rng.stop > r["sourceRange"].stop:
                mappedRanges.append(
                    range(
                        r["destRange"][r["sourceRange"].index(r["sourceRange"].start)],
                        r["destRange"][
                            r["sourceRange"].index(r["sourceRange"].stop - 1)
                        ],
                    )
                )
                mappedRanges = mappedRanges + mapRange(
                    [range(r["sourceRange"].stop + 1, rng.stop)], map
                )
                mappedRanges = mappedRanges + mapRange(
                    [range(rng.start, r["sourceRange"].start - 1)], map
                )
                break

            # range completely in source range
            if (
                rng.start >= r["sourceRange"].start
                and rng.stop <= r["sourceRange"].stop
            ):
                mappedRanges.append(
                    range(
                        r["destRange"][r["sourceRange"].index(rng.start)],
                        r["destRange"][r["sourceRange"].index(rng.stop - 1)],
                    )
                )
                break

            # range on edge of source range
            if rng.start >= r["sourceRange"].start:
                mappedRanges.append(
                    range(
                        r["destRange"][r["sourceRange"].index(rng.start)],
                        r["destRange"].stop,
                    )
                )
                mappedRanges = mappedRanges + mapRange(
                    [range(r["sourceRange"].stop + 1, rng.stop)], map
                )
                break
            if rng.stop <= r["sourceRange"].stop:
                mappedRanges.append(
                    range(
                        r["destRange"].start,
                        r["destRange"][r["sourceRange"].index(rng.stop)],
                    )
                )
                mappedRanges = mappedRanges + mapRange(
                    [range(rng.start, r["sourceRange"].start - 1)], map
                )
                break

        if len(mappedRanges) == 0:
            mappedRanges.append(rng)
        allTheRanges = allTheRanges + mappedRanges
    return allTheRanges


x = seedRanges
for map in maps:
    x = mapRange(x, map)

starts = []
for r in x:
    starts.append(r.start)

print("Part 2:", min(starts))
