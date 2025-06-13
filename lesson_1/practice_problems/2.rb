puts ['ant', 'bat', 'caterpillar'].count do |str|
  puts str, str.length
  str.length < 4
end


# Count will return 2, it will return the number of elements which, when passed to the block, evaluates true. 