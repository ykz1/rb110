=begin

Start:    10:48a
Finish:   10:52a

Requirements:
- Input:      array of numbers, which could be integers of floats
- Output:     number
- Operation:  return the number that appears only once

Solution overview:
- The key to this problem is that all elements will be the same except for one, and so there will always be 2 unique elements and we're looking for the element which only appears once
- Iterate through unique elements from original array (there should always be 2)
- Return the element which only appears once in the original array

=end

def what_is_different(arr)
  arr.uniq.each do |num|
    return num if arr.count(num) == 1
  end
end

p what_is_different([0, 1, 0]) == 1
p what_is_different([7, 7, 7, 7.7, 7]) == 7.7
p what_is_different([1, 1, 1, 1, 1, 1, 1, 11, 1, 1, 1, 1]) == 11
p what_is_different([3, 4, 4, 4]) == 3
p what_is_different([4, 4, 4, 3]) == 3