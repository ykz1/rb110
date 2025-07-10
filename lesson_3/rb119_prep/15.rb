=begin

Start:  9:46a
Finish: 9:58a

Requirements
- Input:      string of numeric digits
- Output:     integer
- Operation:  find the greatest product of four consecutive digits in the string
- Assumptions:
  - input will always have more than 4 digits
  - leading 0s to be ignored (implicit)

Solution overview:
- Iterate from the 4th digit to the final digit
- For each iteration, calculate the product of the current and preceding 3 digits
- Store as max if greater than current max (initiate max at 0)

=end

def greatest_product(str)
  (3...str.length).each_with_object([0]) do |index, max_product|
    product = str[(index - 3)..index].chars.map(&:to_i).inject(:*)
    max_product[0] = [max_product[0], product].max
  end[0]
end

p greatest_product('23456') == 360      # 3 * 4 * 5 * 6
p greatest_product('3145926') == 540    # 5 * 9 * 2 * 6
p greatest_product('1828172') == 128    # 1 * 8 * 2 * 8
p greatest_product('123987654') == 3024 # 9 * 8 * 7 * 6