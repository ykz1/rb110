a = 2
b = [5, 8]
arr = [a, b] # [2, [5, 8]]

arr[0] += 2 # [4, [5, 8]]
arr[1][0] -= a #[4, [3, 8]]

p arr
p b

# Note: b and arr[1] reference the same object, and so when we change arr[1] we are also changing the underlying object that b points to