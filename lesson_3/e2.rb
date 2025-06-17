require 'pry-byebug'

def fizzbuzz(arr)
  arr.map do |num|
    # binding.pry
    if num % 5 == 0 && num % 3 == 0
      'FizzBuzz'
    elsif num % 5 == 0
    'Buzz'
    elsif num % 3 == 0
      'Fizz'
    else
      num
    end
  end
end

p fizzbuzz([1, 3, 5 ,6 ,7 ,8, 10, 3, 15, 9])