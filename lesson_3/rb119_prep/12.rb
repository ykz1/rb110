=begin

Start:  6:57a
Finish: 7:02a

Requirements:
- Input:      string
- Output:     true / false
- Operation:  determine whether string provided is a "pangram"—contain all letters of alphabet
- Assumptions:
  - Ignore case

Solution overview:
- Iterate through all letters of alphabet and check whether string provided contains that letter

=end

def is_pangram(str)
  ('a'..'z').each do |letter|
    return false if !str.downcase.include?(letter)
  end
  true
end

p is_pangram('The quick, brown fox jumps over the lazy dog!') == true
p is_pangram('The slow, brown fox jumps over the lazy dog!') == false
p is_pangram("A wizard’s job is to vex chumps quickly in fog.") == true
p is_pangram("A wizard’s task is to vex chumps quickly in fog.") == false
p is_pangram("A wizard’s job is to vex chumps quickly in golf.") == true

my_str = 'Sixty zippers were quickly picked from the woven jute bag.'
p is_pangram(my_str) == true