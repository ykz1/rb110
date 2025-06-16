my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

=begin
Line    Action            Object             Side Effect       Return Value          Used?
1       Variable assign   Outer array        No                Assiend value         No
1       #each call        Outer array        No                Self                  No
1~7     Block execution   Sub-array          No                [18,7], [3,12]        Yes - passed to #each
2       #each call        Sub-array          No                Self                  Yes, return value of outer block    
2~6     Block execution   Sub-array elements No                18,7 then 3,12        Yes - passed to #each
3       if conditional                                         True true false true  Yes - return value of inner block
4       #puts call                           Yes
=end


[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# Return value in this example = 
# Inner #map: passed [1, 2], then [3, 4]
# Returns [2, 4] then [6, 8]
# Outer #map: returns [[2, 4], [6, 8]]


[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

# Array with 2 elements, each a hash, calls #select
# 1st iteration, passes hash {a:'ant', b:'elephant'}
# #all? invoked on hash
# Check if 1st character of each value, 'a' and 'e', matches key converted to string, 'a', 'b'
# True for 'ant' -> 'a' / ':a' -> 'a'
# False for 'elephant' -> 'e' / ':b' -> 'b'
# #all? returns false to block
# 2nd iteration, passes 2nd hash {c:'cat'}
# #all? called and returns true: 'cat' -> 'c' == ':c' --> 'c'
# only second element selected into new array returned by #select: [{c: 'cat'}]

# If we used #any? instead of #all?, then both hashes would be returned because in the first hash, a: 'ant' would return true

[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]

