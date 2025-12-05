with open("input.txt") as f:
    ranges, ids = f.read().strip().split("\n\n")

    total = 0

    for item_id in map(int, ids.splitlines()):
        for r in ranges.splitlines():
            start, end = map(int, r.split("-"))
            if start <= item_id <= end:
                total += 1
                break

    print(total)
