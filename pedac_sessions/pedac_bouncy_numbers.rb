def bouncy_count(arr)
  arr.map do |number|
    number = number.to_s
    counter = 1
    ascends = false
    descends = false
    until counter >= number.length
      case (number[counter].to_i <=> number[counter - 1].to_i)
      when 1 then ascends = true
      when -1 then descends = true
      end
      counter += 1
    end
    ascends && descends
  end.count(true)
end




p bouncy_count([]) == 0
p bouncy_count([11, 0, 345, 21]) == 0
p bouncy_count([121, 4114]) == 2
p bouncy_count([176, 442, 80701644]) == 2


=begin
Algorithm:

Test each number within given list / array. For each number...
1. Convert number from integer to string
2. If the number string is 2 characters or shorter, it is not a bouncy number
3. If the number string is 3 characters or longer (else statement), then iterate through each character in string, starting with the second character
  a Compare the character to the preceding character
  b If it is greater, then set ascending flag to true
  c If it is lesser, then set descending flag to true
  d If both ascending and descending flags are true, then we can stop iterating through the digits of this number, because it is a bouncy number
  e If we get to the end of all the digits of the number string, the number is bouncy only if both flags are true
4. Save that number as "bouncy" or true back in our list / array
5. Return a count of the number of "bouncy" or "true"s in our list / array

=end