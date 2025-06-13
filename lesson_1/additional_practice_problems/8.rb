numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

p numbers

# Ruby would iterate by index
# Index 0: 1 would be printed, then it will be removed and elements 2, 3, 4 would all move down one index number
# Index 1: 3 would be printed, then 2 would be removed, and elements 3 and 4 would move down one index number
# Stop iterating.
# numbers would now be [3, 4]

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

p numbers

# Index 0: 1 would be printed, then 4 would be removed from the end of the array
# Index 1: 2 would be printed, then 3 would be removed
# Stop iterating
# numbers would now be [1, 2]