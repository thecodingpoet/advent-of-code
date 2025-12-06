from collections import defaultdict

with open("input.txt") as file:
    total = 0
    buckets = defaultdict(list)

    for line in file.readlines():
        for index, value in enumerate(line.split()):
            buckets[index].append(value)

    for *nums, operation in buckets.values():
        total += eval(operation.join(nums))

print(total)
