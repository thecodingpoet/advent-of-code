dial = 50
count = 0

with open('input.txt', 'r') as file:
    for line in file:
        rotation = line[0]
        distance = int(line[1:])

        if rotation == 'L':
            dial -= distance
        else:
            dial += distance

        dial %= 100

        if dial == 0:
            count += 1

    print(count)
