arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

arr2 = arr.sort_by do |sub_array|
  sub_array.select do |num|
    num.odd?
  end
end


p arr2 == [[1, 8, 3], [1, 5, 9], [6, 1, 7], [1, 6, 9]]