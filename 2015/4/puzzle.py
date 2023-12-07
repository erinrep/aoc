print("Day 4: The Ideal Stocking Stuffer")

import hashlib
import re


def match_hash(key, startswith):
    num = 1
    while 1:
        result = hashlib.md5(f"{key}{num}".encode("UTF-8"))
        if re.search(f"^{startswith}", result.hexdigest()):
            break
        num += 1
    return num


input = "yzbqklnj"
print("Part 1:", match_hash(input, "00000"))
print("Part 2:", match_hash(input, "000000"))  # slow
