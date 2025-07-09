require 'pry-byebug'
=begin

Start: 1:47p
Finish: 2:01p

Requirements:
- Input: two string arguments
- Output: integer
- Operation: count the number of complete occurrences of str2 within str1
- Implied:
  - 

Solution overview:
- Loop
- If str2 can be found in str1, count += 1 and replace str1 with '' within str2
- Stop looping when str1's length is less than str2

=end

def count_substrings(str1, str2)
  count = 0
  until str1.length < str2.length
    if str1.include?(str2)
      count += 1
      str1 = str1.sub(str2, '')
    else
      break
    end
  end
  count
end

p count_substrings('babab', 'bab') == 1
p count_substrings('babab', 'ba') == 2
p count_substrings('babab', 'b') == 3
p count_substrings('babab', 'x') == 0
p count_substrings('babab', 'x') == 0
p count_substrings('', 'x') == 0
p count_substrings('bbbaabbbbaab', 'baab') == 2
p count_substrings('bbbaabbbbaab', 'bbaab') == 2
p count_substrings('bbbaabbbbaabb', 'bbbaabb') == 1