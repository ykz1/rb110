=begin

Start:  10:09a
Finish: 10:20a

Requirements:
- Input:      Array of integers
- Output:     Integer
- Operation:  Find the difference between sum of integers, and the next smallest prime
- Assumptions:
  - Array will always have 2 or more integers
  - All values will be positive
  - There may be duplicates
  - The integers given may sum to be a prime, in which we're looking for the next smallest prime

Solution overview
- This problem is about finding the next smallest prime
- Find sum of integers given
- Starting from this sum and incrementing +1 at a time, check whether prime

=end
def nearest_prime_sum(arr)
  sum = arr.sum
  diff = 1
  loop do
    num = sum + diff
    break if is_prime?(num)
    diff += 1
  end
  diff
end

def is_prime?(int)
  (2..(int / 2)).each do |num|
    return false if int % num == 0
  end
  true
end

p nearest_prime_sum([1, 2, 3]) == 1        # Nearest prime to 6 is 7
p nearest_prime_sum([5, 2]) == 4           # Nearest prime to 7 is 11
p nearest_prime_sum([1, 1, 1]) == 2        # Nearest prime to 3 is 5
p nearest_prime_sum([2, 12, 8, 4, 6]) == 5 # Nearest prime to 32 is 37

# Nearest prime to 163 is 167
p nearest_prime_sum([50, 39, 49, 6, 17, 2]) == 4