a = ['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

p a

# Will return a hash with 3 values matching the array, and the first character of each element as its key: {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}