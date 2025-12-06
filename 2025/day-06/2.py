with open("input.txt") as file:
    grid = [line.rstrip("\n") for line in file.readlines()]

    cols = list(zip(*grid))

    buckets = []
    bucket = []

    for col in cols:
        if all(c == " " for c in col):
            if bucket:
                buckets.append(bucket)
                bucket = []
        else:
            bucket.append(col)

    buckets.append(bucket)

    total = 0

    for bucket in buckets:
        operation = bucket[0][-1]
        nums = ["".join(x[:-1]) for x in bucket]

        total += eval(operation.join(nums))

print(total)
