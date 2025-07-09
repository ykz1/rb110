=begin

Start: 1:02
Finish: 1:11

Requirements:
- Input: string
- Output: hash
- Operation: find the unique letters from string and save lowercase of those characters as keys in hash with value being frequency of occurrence of each character within the string
- Assumptions:
  - Ignore anything that is not an alphabetical character 
  - Ignore uppercase characters

Solution overview:
- Iterate through all character of string
- If character is a-z then save as key of hash with value being count of character...since we're iterationg +=1 that key with iteration
- return hash

=end

def count_letters(str)
  chars = str.chars
  output = Hash.new(0)
  chars.each do |char|
    output[char] += 1 if ('a'..'z').include?(char)
  end
  output
end

expected = {'w' => 1, 'o' => 2, 'e' => 3, 'b' => 1, 'g' => 1, 'n' => 1}
p count_letters('woebegone') == expected

expected = {'l' => 1, 'o' => 1, 'w' => 1, 'e' => 4, 'r' => 2,
            'c' => 2, 'a' => 2, 's' => 2, 'u' => 1, 'p' => 2}
p count_letters('lowercase/uppercase') == expected

expected = {'u' => 1, 'o' => 1, 'i' => 1, 's' => 1}
p count_letters('W. E. B. Du Bois') == expected

p count_letters('x') == {'x' => 1}
p count_letters('') == {}
p count_letters('!!!') == {}

puts



# Incorrect implemention below provided by LSBot in feedback:

def count_letters2(str)
  output = Hash.new(0)
  str.each_char do |char|
    char_down = char.downcase
    output[char_down] += 1 if ('a'..'z').include?(char_down)
  end
  output
end
expected = {'w' => 1, 'o' => 2, 'e' => 3, 'b' => 1, 'g' => 1, 'n' => 1}
p count_letters2('woebegone') == expected

expected = {'l' => 1, 'o' => 1, 'w' => 1, 'e' => 4, 'r' => 2,
            'c' => 2, 'a' => 2, 's' => 2, 'u' => 1, 'p' => 2}
p count_letters2('lowercase/uppercase') == expected

expected = {'u' => 1, 'o' => 1, 'i' => 1, 's' => 1}
p count_letters2('W. E. B. Du Bois') == expected

p count_letters2('x') == {'x' => 1}
p count_letters2('') == {}
p count_letters2('!!!') == {}