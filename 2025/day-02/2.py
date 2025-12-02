with open('input.txt') as f:
    contents = f.read()
    ranges = contents.split(',')

    def invalid(n):
        s = str(n)
        mid = len(s) // 2

        return any(s[:i] * (len(s) // i) == s for i in range(1, mid + 1))

    total = 0

    for r in ranges:  
        start, stop = r.split('-')
        start = int(start)
        stop = int(stop)

        for i in range(start, stop + 1):
            if invalid(i):
                total += i

print(total)
