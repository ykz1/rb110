a = [1, 2, 3].reject do |num|
  puts num
end

p a

# #reject will return a new array with elements from the original array which, when passed to our block, returns a falsy evaluation. #puts always returns nil and so every element passed will return false. [1, 2, 3] will be returned