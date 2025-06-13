a = [1, 2, 3].any? do |num|
  puts num
  num.odd?
end

p a

# #any? returns true if any iterations of the block's execution return true when passed elements from the calling array. Elements 1 will return true and so #any? will return true after executing the block one time with the first element.