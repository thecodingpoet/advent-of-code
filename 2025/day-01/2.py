dial = 50
count = 0

with open("input.txt") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        rotation = line[0]
        distance = int(line[1:])

        step = 1 if rotation == "R" else -1

        for _ in range(distance):
            dial = (dial + step) % 100
            if dial == 0:
                count += 1

    print(count)
