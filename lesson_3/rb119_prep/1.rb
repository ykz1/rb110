=begin
Start: 11:28a

Requirements:
- Input: array of numbers
- Output: new array with same number of elements
- Operation: for each number, count the number of unique elements which are smaller than it

Solution overview:
- Create new array of unique numbers
- Map original array into new array with each element being the number of elements from the unique array which are smaller than
- Data: array for unique array, and #map for array to return

Finish: 11:35a
=end

def smaller_numbers_than_current(arr)
  unique_array = arr.uniq
  arr.map do |num| 
    unique_array.count { |uniques| uniques < num }
  end
end

p smaller_numbers_than_current([8, 1, 2, 2, 3]) == [3, 0, 1, 1, 2]
p smaller_numbers_than_current([7, 7, 7, 7]) == [0, 0, 0, 0]
p smaller_numbers_than_current([6, 5, 4, 8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]

my_array = [1, 4, 6, 8, 13, 2, 4, 5, 4]
result   = [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current(my_array) == result