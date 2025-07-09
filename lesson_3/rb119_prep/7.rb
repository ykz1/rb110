=begin

Start: 1:21p
Finish: 1:37p

Requirements:
- Input: array of integers
- Output: integer
- Operation: find the number of complete pairs of identical integers

Solution overview:
- Sort array into new array
- Start popping from the sorted array, storing each in register
- With each successive pop, compare vs register
- If match, count += 1 and clear register
- If no match, save popped element into register

=end

def pairs(arr)
  arr = arr.sort
  register = nil
  pairs = 0
  until arr.size == 0
    popped = arr.pop
    if popped == register
      pairs += 1
      register = nil
    else
      register = popped
    end
  end
  pairs
end

p pairs([3, 1, 4, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7]) == 3
p pairs([2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4]) == 4
p pairs([]) == 0
p pairs([23]) == 0
p pairs([997, 997]) == 1
p pairs([32, 32, 32]) == 1
p pairs([7, 7, 7, 7, 7, 7, 7]) == 3