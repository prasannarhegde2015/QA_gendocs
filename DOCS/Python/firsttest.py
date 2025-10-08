rows = int(input("Please enter number of rows: "))
for i in range(rows):
    half= rows-1
    print(end=" " * half)#append
    for j in range(2*i +1):
        print(end="*")#append
    print(end=" " * half)#append
    print()#newline
    rows = rows -1
