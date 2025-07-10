=begin

Start:  7:13a
Finish: 7:22a

Requirements:
- Input:      integer
- Output:     integer
- Operation:  sum of all multiples of 7 or 11 that are less than integer given
- Assumptions:
  - If multiple of both 7 or 11, count only once
  - Negative numbers should be treated the same, i.e. they would all return 0

Solution overview:
- Return 0 if integer < 7
- Iterate up starting at 1 with index i, if i * 7 is smaller than integer given, add i * 7 to array, otherwise stop iterating
- Do the same with 11
- Remove duplicates in array
- Return sum of array

=end

def seven_eleven(num)
  return 0 if num < 7
  multiples = []
  [7, 11].each do |factor|
    counter = 1
    loop do
      multiple = factor * counter
      multiple < num ? multiples << multiple : break
      counter += 1
    end
  end
  multiples.uniq.sum
end

p seven_eleven(10) == 7
p seven_eleven(11) == 7
p seven_eleven(12) == 18
p seven_eleven(25) == 75
p seven_eleven(100) == 1153
p seven_eleven(0) == 0
p seven_eleven(-100) == 0