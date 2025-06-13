[1, 2, 3].select do |num|
  num > 5
  'hi'
end

=begin
We call #select on an array with 3 elements: 1, 2, 3.
With each iteration of #select, we pass in our elements and assign their values to parameter `num`.
The returned value of the block is what determines whether each element is included in the array returned by the method.
The last line of the block is string 'hi', which is always truthy—all elements of the array will be selected and [1, 2, 3] will be returned.

=end