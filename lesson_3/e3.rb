require 'pry-byebug'

def count_letters(string, char)
  string.count(char)
end

def single_letters(string)
  binding.pry
  singles = []
  string.chars.each do |char|
    letter_count = count_letters(string, char)

    if letter_count == 1
      singles << char.downcase
    end
  end

  singles
end

# p single_letters('abc') == ['a', 'b', 'c']
# p single_letters('Hello World') == ['h', 'e', ' ', 'w', 'r', 'd']
p single_letters('Cool cat') == ['l',' ', 'a', 't']

