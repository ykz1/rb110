=begin

Start:  10:01a
Finish: 10:07a

Requirements:
- Input:      string
- Output:     integer
- Operation:  ignoring case, the number of alphanumeric characters which appear more than once
- Assumptions:
  - assume input will contain only alphanumerics
  - case insensitive

Solution overview:
- Downcase string and convert to array of chars
- Iterate through unique chars
- For each unique char, count the number of times it occurs in the str
- If occurs more than once, then add +1 to accumulator (to be initialize prior at 0)
- Return accumulator

=end

def distinct_multiples(str)
  str.downcase.chars.uniq.each_with_object([0]) do |char, acc|
    acc[0] += 1 if str.downcase.count(char) > 1
  end[0]
end

p distinct_multiples('xyz') == 0               # (none
p distinct_multiples('xxyypzzr') == 3          # x, y, z
p distinct_multiples('xXyYpzZr') == 3          # x, y, z
p distinct_multiples('unununium') == 2         # u, n
p distinct_multiples('multiplicity') == 3      # l, t, i
p distinct_multiples('7657') == 1              # 7
p distinct_multiples('3141592653589793') == 4  # 3, 1, 5, 9
p distinct_multiples('2718281828459045') == 5  # 2, 1, 8, 4, 5