a = [1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

p a

# will return [1, nil, nil] because puts evaluates to nil.