=begin

Start: 12:37
Finish: 12:51

Requirements:
- Input = array of integers
- Output = new array of two integers
- Operation = find the two numbers who are closest together in value

Solution overview:
- Find all 2-pair combinations within given array, save to new array
- Calculate and store the sums of 2-pair combinations within our new array
- Return the 2-pair combination with the lowest sum

=end

def closest_numbers(arr)
  combos = []
  arr.combination(2) { |combo| combos << combo }
  sums = combos.map { |combo| (combo[0] - combo[1]).abs }
  combos[sums.index(sums.min)]
end

p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 22, 7, 17]) == [12, 7]