def select_fruit(hash)
  items = hash.keys
  counter = 0
  output = {}

  loop do
    break if counter == items.size # note: moving this to the top of our loop captures the scenario where our hash is empty
    current_item = items[counter]
    output[current_item] = hash[current_item] if hash[current_item] == 'Fruit'
    counter += 1
  end

  output
end


produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}


# ==================
# Mutating double numbers:
# Updated to take a multiplier input:

def double_numbers(arr)
  counter = 0
  
  loop do
    break if counter == arr.size
    arr[counter] *= 2
    counter += 1
  end
end

def multiply(arr, multiplier)
  counter = 0

  loop do
    break if counter == arr.size
    arr[counter] *= multiplier
    counter += 1
  end
end


my_numbers = [1, 4, 3, 7, 2, 6]
double_numbers(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers # => [2, 8, 6, 14, 4, 12]

my_numbers = [1, 4, 3, 7, 2, 6]
multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]
p my_numbers