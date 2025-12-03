with open('input.txt') as file:
    total = 0

    for line in file:
        line = line.strip()

        n = len(line)

        best = 0

        for i in range(n):
            for j in range(i + 1, n):
              best = max(best, int(line[i] + line[j]))

        total += best

    print(total)
