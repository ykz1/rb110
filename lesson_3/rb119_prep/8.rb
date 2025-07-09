=begin

Start: 1:38p
Finish: 1:46p

Requirements:
- Input: non-empty lowercase string
- Output: integer
- Operation: find the length of the longest substring of consecutive vowels

Solution overview:
- There is probably a regex solution which solves this in one line. We will find another way
- Iterate through characters in string
- When vowel found, start saving to substring variable
- When consonant found, 1) save length of substring as max if greater than previous max; 2) clear substring

=end
def longest_vowel_substring(str)
  max_length = 0
  substring = ''
  str.chars.each do |char|
    if 'aeiou'.include?(char)
      substring << char
      max_length = [max_length, substring.size].max
    else
      substring = ''
    end
  end
  max_length
end

p longest_vowel_substring('cwm') == 0
p longest_vowel_substring('many') == 1
p longest_vowel_substring('launchschoolstudents') == 2
p longest_vowel_substring('eau') == 3
p longest_vowel_substring('beauteous') == 3
p longest_vowel_substring('sequoia') == 4
p longest_vowel_substring('miaoued') == 5