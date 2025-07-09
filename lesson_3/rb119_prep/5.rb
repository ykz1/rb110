=begin

Start: 12:52
Finish: 1:00

Requirements:
- Input: string
- Output: one-character string
- Operation: find the character that appears most frequently in the string
- Considerations:
  - Ignore case
  - If multiple characters appear the same number of times, 
  - Implied: consider all characters, including spaces

Solution overview:
- Convert string to lowercase
- Save an array of all the unique characters in given string
- Find the number of occurences of each character
- Return the character with the greatest frequency

=end

def most_common_char(str)
  str = str.downcase
  chars = str.chars.uniq
  frequencies = chars.map { |char| str.count(char) }
  chars[frequencies.index(frequencies.max)]
end

p most_common_char('Hello World') == 'l'
p most_common_char('Mississippi') == 'i'
p most_common_char('Happy birthday!') == 'h'
p most_common_char('aaaaaAAAA') == 'a'

my_str = 'Peter Piper picked a peck of pickled peppers.'
p most_common_char(my_str) == 'p'

my_str = 'Peter Piper repicked a peck of repickled peppers. He did!'
p most_common_char(my_str) == 'e'