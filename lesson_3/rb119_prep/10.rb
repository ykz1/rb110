=begin

Start: 6:28a
Finish: 6:36a

Requirements:
- Input:      string of digits
- Output:     integer
- Operation:  find the number of even-numbered substrings that can be formed

Solution overview:
- Even numbered substrings must end in an even number
- The digit position determines how many even-numbered substrings can end in that digit
- 1356 has 6 in the 4th position and so there are 4 numbers that can end in that even digit
- 13568 has 4 even-numbered substrings ending in 6, and then an 8 in the 5th position so 5 more even-numbered substrings for a total of 9
- Iterate through the characters of substring, with index (start at 1)
- Convert each to integer
- If even, then add the digit number of character to accumulator 

=end

def even_substrings(str)
  accumulator = 0
  str.chars.each_with_index do |char, index|
    index += 1
    accumulator += index if char.to_i.even?
  end
  accumulator
end

p even_substrings('1432') == 6
p even_substrings('3145926') == 16
p even_substrings('2718281') == 16
p even_substrings('13579') == 0
p even_substrings('143232') == 12