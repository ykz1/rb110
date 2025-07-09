require 'pry-byebug'

=begin

Start: 11:45a

Requirements:
- Input: array of integers
- Output: one integer or nil
- Operation: calculate the minimum sum of 5 consecutive elements from the original array, return nil if fewer than 5 elements 

Solution overview:
- Return nil if fewer than 5 elements
- Loop from 5 to size of array given, with index starting at 5
- Calculate sum of element at index and preceding 4 elements
- Save as minimum_sum if it is less than current minimum_sum
- Return minimum_sum

Finish: 12:01p

=end

def minimum_sum(arr)
  size = arr.size
  return nil if size < 5

  sum = arr[0..4].sum

  4.upto(size - 1) do |index|
    sum = [sum, arr[(index - 4)..index].sum].min
  end

  sum
end


p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, -5]) == 9
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10


def minimum_sum2(arr)
  return nil if arr.size < 5

  min_sum = arr[0..4].sum
  (5...arr.size).each do |index| # only loops if size > 5 i.e. skips if size is exactly 5
    min_sum = [min_sum, arr[(index - 4)..index].sum].min
  end

  min_sum
end
puts
p minimum_sum2([1, 2, 3, 4]) == nil
p minimum_sum2([1, 2, 3, 4, 5, -5]) == 9
p minimum_sum2([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum2([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum2([-1, -5, -3, 0, -1, 2, -4]) == -10