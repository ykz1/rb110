=begin

Start:  10:26a
Finish: 10:40a

Requirements:
- Input:      array of integers
- Output:     integer
- Operation:  return the index of the element which splits the array into 2 arrays with equal sums. Return -1 if no such split possible. The element is excluded from either split sub-arrays
- Assumptions:
  - If an array has multiple answers, return the smallest index (to clarify, don't return the index with the smallest value)

Solution overview:
- Iterate through all the elements of the given array
- For each element, compare the sums of two sub arrays with all elements to its left and elements to its right
- Return that element's index if the sums equal
- Return -1 if finished iterating without finding an element which split the array into two sub-arrays with equal sums
- Note: if there are multiple answers, we should return the smallest index and so we can stop iterating once we find our first element which satisfies our requirement

=end

def equal_sum_index(arr)
  arr.each_with_index do |_, idx|
    sum_left = arr[0...idx].sum
    sum_right = arr[(idx + 1)..-1].sum
    return idx if sum_left == sum_right
  end
  -1
end

p equal_sum_index([1, 2, 4, 4, 2, 3, 2]) == 3
p equal_sum_index([7, 99, 51, -48, 0, 4]) == 1
p equal_sum_index([17, 20, 5, -60, 10, 25]) == 0
p equal_sum_index([0, 2, 4, 4, 2, 3, 2]) == -1

# The following test case could return 0 or 3. Since we're
# supposed to return the smallest correct index, the correct
# return value is 0.
p equal_sum_index([0, 20, 10, -60, 5, 25]) == 0
