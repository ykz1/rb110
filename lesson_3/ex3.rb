require 'pry'

def double_num(num)
  num * 2
end

arr = [1, 2, 3].map do |num|
  binding.pry
  double_num(num)
end

p arr