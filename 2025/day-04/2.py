with open("input.txt") as f:
  grid = [list(line.rstrip("\n")) for line in f]

  m = len(grid)
  n = len(grid[0])

  directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]

  def valid(r, c):
    count = 0
  
    for dr, dc in directions:
      r2, c2 = r + dr, c + dc

      if 0 <= r2 < m and 0 <= c2 < n and grid[r2][c2] == "@":
        count += 1

    return count < 4

  total = 0

  while True:
    curr = 0

    for r in range(m):
      for c in range(n):
        if grid[r][c] == "@" and valid(r, c):
          grid[r][c] = "."
          curr += 1

    total += curr

    if curr == 0:
      break

  print(total)
