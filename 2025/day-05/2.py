with open("input.txt") as f:
    ranges_section, _ = f.read().strip().split("\n\n")

    ranges = []
    for line in ranges_section.splitlines():
        start, end = line.split("-")
        ranges.append((int(start), int(end)))

    ranges.sort()

    merged = []
    for start, end in ranges:
        if merged and start <= merged[-1][1] + 1:
            merged[-1] = (merged[-1][0], max(merged[-1][1], end))
        else:
            merged.append((start, end))

    total = sum(end - start + 1 for start, end in merged)
    print(total)
