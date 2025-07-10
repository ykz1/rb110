=begin

Start:  7:03a
Finish: 7:10a

Requirements:
- Input:      two string arguments
- Output:     true / false
- Operation:  ignoring order, str1 contains str2
- Assumptions:
  - a nil str2 should return true for any str1
  - ignore case

Solution overview:
- Iterate through all unique characters of str2
- For each unique character, compare the frequency of that character in str2 versus str1
- Return false if str2 has more of any character than str1
- Return true otherwise (implicit)

=end

def unscramble(str1, str2)
  str2.chars.uniq.each do |char|
    return false if str2.count(char) > str1.count(char)
  end
  true
end

p unscramble('ansucchlohlo', 'launchschool') == true
p unscramble('phyarunstole', 'pythonrules') == true
p unscramble('phyarunstola', 'pythonrules') == false
p unscramble('boldface', 'coal') == true

# Additional test cases
p unscramble('boldface', '') == true
p unscramble('', 'coal') == false
p unscramble('', '') == true