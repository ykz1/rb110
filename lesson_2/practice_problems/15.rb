arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

arr2 = arr.select do |hsh|
  hsh.all? do |_, sub_array|
    sub_array.all? { |num| num.even? }
  end
end

p arr2