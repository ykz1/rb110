arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

sorted_array = arr.map do |sub_array|
  sub_array.sort do |a, b|
    b <=> a
  end
end

p sorted_array

  # if arr[0].is_a?(Integer)
  #   arr.sort