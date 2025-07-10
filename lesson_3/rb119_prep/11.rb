=begin

Start:  6:37a
Finish: 6:55a

Requirements:
- Input:      non-empty string
- Output:     array with two elements: string and integer
- Operation:  find the shortest possible substring which, when repeated x times, make the whole string

Solution overview:
- This is similar to finding all the factor pairs (i and j) of a number and returning the smallest i that meet some criteria, where that criteria is that the first i characters of a string, when repeated j times, form the whole string
- Find the length of the string provided
- Find the factor pairs of for length
- Start with the smallest factor pair (i and j) and if the first i characters * j equals the string, then we have found our output

=end

def repeated_substring(str)
  length = str.length
  factor_pairs = get_factor_pairs(length)
  factor_pairs.each do |(i, j)|
    substring = str[0..(i - 1)]
    return [substring, j] if substring * j == str
  end

end

def get_factor_pairs(length)
  (1..length).each_with_object([]) do |num, pairs|
    pairs << [num, length / num] if length % num == 0
  end
end

p repeated_substring('xyzxyzxyz') == ['xyz', 3]
p repeated_substring('xyxy') == ['xy', 2]
p repeated_substring('xyz') == ['xyz', 1]
p repeated_substring('aaaaaaaa') == ['a', 8]
p repeated_substring('superduper') == ['superduper', 1]
