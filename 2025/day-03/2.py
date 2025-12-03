with open('input.txt') as file:
    total = 0

    for line in file:
        line = line.strip()

        n = len(line)

        stack = []

        for i in range(n):
            while stack and line[i] > stack[-1] and (n - i + len(stack)) > 12:
                stack.pop()

            stack.append(line[i])

            while len(stack) > 12:
                stack.pop()

        total += int(''.join(stack))

    print(total)
       