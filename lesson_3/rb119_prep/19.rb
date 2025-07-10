=begin

Start:  10:41
Finish: 10:45

Requirements:
- Input:      array of integers
- Output:     integer
- Operation:  find the integer that appears and odd number of times
- Assumptions:
  - There will only be one integer that appears an odd number of times

Solution overview:
- Iterate through uniq elements from given array
- For each unique element, count how many times it appears in the original array and return the element if the count is odd

=end
def odd_fellow(arr)
  arr.uniq.each do |num|
    return num if arr.count(num).odd?
  end
end

p odd_fellow([4]) == 4
p odd_fellow([7, 99, 7, 51, 99]) == 51
p odd_fellow([7, 99, 7, 51, 99, 7, 51]) == 7
p odd_fellow([25, 10, -6, 10, 25, 10, -6, 10, -6]) == -6
p odd_fellow([0, 0, 0]) == 0