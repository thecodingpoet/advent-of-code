with open('input.txt') as f:
    contents = f.read()
    ranges = contents.split(',')

    def invalid(n):
        s = str(n)
        half = len(s) // 2
    
        return s[:half] == s[half:]


    total = 0

    for r in ranges:  
        start, stop = r.split('-')
        start = int(start)
        stop = int(stop)
        
        for i in range(start, stop + 1):
            if invalid(i):
                total += i
            
print(total)
    