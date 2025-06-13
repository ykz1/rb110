arr = [1, 2, 3, 4, 5]
p arr.take(2)

p arr

# #take will return the first n elements of its calling array and return those elements, where n is the argument passed to #take. #take is not a mutating method and will not change the calling array.

# In this case, line 2 will return the first two elements [1, 2]. After #take's invocation, arr will remain [1, 2, 3, 4, 5]