=begin

Start: 12:15
Finish: 12:29

Requirements:
- Input: string
- Output: new string
- Operation: capitalize every second character of every third word

Solution overview:
- Iterate with index through words within given string -- use #map so we return a new array which we can re-join into a string with #join
- Iterate through characters within in each word
- Considerations:
  - What if less than 3 words?
  - What if words have less than two characters?
- Option 1: use #map and #join twice—one for each of our iterations
- Option 2: use #each_with_index for both iterations and if statement to change cases
- Option 3: iterate by our skips (i.e. every 2...every 3) and change only relevant characters. This is probably most efficient but difficult to implement

=end

def to_weird_case(str)
  words = str.split

  return str if words.size <= 2

  words.map.with_index do |word, idx1|
    if (idx1 + 1) % 3 == 0
      word.chars.map.with_index do |char, idx2|
        if (idx2 + 1) % 2 == 0
          char.upcase
        else
          char
        end
      end.join
    else
      word
    end

  end.join(' ')
end


original = 'Lorem Ipsum is simply dummy text of the printing world'
expected = 'Lorem Ipsum iS simply dummy tExT of the pRiNtInG world'
p to_weird_case(original) == expected

original = 'It is a long established fact that a reader will be distracted'
expected = 'It is a long established fAcT that a rEaDeR will be dIsTrAcTeD'
p to_weird_case(original) == expected

p to_weird_case('aaA bB c') == 'aaA bB c'

original = "Mary Poppins' favorite word is supercalifragilisticexpialidocious"
expected = "Mary Poppins' fAvOrItE word is sUpErCaLiFrAgIlIsTiCeXpIaLiDoCiOuS"
p to_weird_case(original) == expected