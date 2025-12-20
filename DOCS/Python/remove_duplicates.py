import sys

# write your answer here
arr_len = input("Please Enter a Array Length First: ")
input_list = []
print("Please Enter a Array elements one by one 👇👇")
for i in range (0,int(arr_len)):
    arr_elem = input(f"Please Enter Element # {i+1} ")
    input_list.insert(i,arr_elem)

def remove_duplicates(input_list):
    clean_list=[]
    i=0
    for  elem in input_list:
        if elem not  in  clean_list:
            clean_list.insert(i,elem)
            i=i+1
    clean_list.sort()        
    return clean_list
    
print("Cleaned and Sorted List is as shown below: 🎉🎉")
cleaned = remove_duplicates(input_list)
for  clean_elem in cleaned:
    print(clean_elem)
 

