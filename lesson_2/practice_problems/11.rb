arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

arr2 = arr.map do |sub_array|
  sub_array.select do |num|
    num % 3 == 0
  end
end

p arr2 == [[], [3, 12], [9], [15]]