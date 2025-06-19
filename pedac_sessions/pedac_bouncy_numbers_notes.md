/*

BOUNCY COUNT

Some numbers have only ascending digits, like 123, 3445, 2489, etc.

Some numbers have only descending digits, like 321, 5443, 9842, etc.

A number is "bouncy" if it has both ascending and descending digits, like 313, 92543, etc.

Write a method that takes a list of numbers and counts how many of them are bouncy.

  

P

Given an array of integer inputs, return an integer representing the count of numbers that are considered "bouncy"

  

Requirements/Rules

- Explicit:

Bouncy : 121..., 313...

non: , 321, 123

implicit:

empty = 0

single digit is not bouncy

next digit is asc/descd, remains the same, opposite = bouncy

Data structures

Input: array of integers

Output: integer

  

Intermediate:

- list of strings, e.g. ['1', '1'] for the number 11

- array of digits, [1, 2, 3]

- strings e.g. '11' for 11

- boolean values to track if a digit is bigger, smaller or the same, than previous digit

  

High-level strategies

- James: Split the number into a list of digits as strings, ['1', '1'], iterate over the list and use two flags for recording when the number goes up or down. For each iteration, compare digit to previous and set flags as required. When you get ot the end, if both flags are true, it is a bouncy number.

  

- Larry: guard clause, if a number is only 1 or 2 digits, it is not bouncy, guard clause to return zero if array is empty

  

- Josh: helper function digits in the list/array, return 0 if not bouncy, or 1 if bouncy, sum(list)

  

- Crystal: test for ascending and descending numbers.

  

- Kyle: sort the number as an array is it the same as the original number. ** Be careful about how you define ascending/descending in terms of the same number appearing consecutively.**

  

Algorithm:

Language agnostic for a non-programmer

  

Helper functions

  

Descriptive variable names

  

Run test cases through algo

  
  

James

# Define Algorithm

# helper - `is_bouncy`

# init `goes_up` to `False`

# init `goes_down` to `False`

# convert `number` to `string`

# split string into a list of `digits`

# if the length of digits is greater than 2

# iterate over the indexes of `digits`

# if index is greater than 0

# init `prev` to `digit` at `index` - 1 in `digits`

# init `curr` to `digit` at `index` in `digits`

# if `prev` is less than `curr`

# set `goes_up` to `True`

# if `curr` is less than `prev`

# set `goes_down` to `True`

# return `goes_up` and `goes_down`

# algo

# init `total` to 0

# if length of `numbers` is 0 then return total

# iterate over `num` in `numbers`

# if `is_bouncy()`

# increment `total`

# return `total`

  

Crystal

- Define an `is_bouncy?` helper method to determine if a number is bouncy

- Count number of bouncy nums in array

  

`is_bouncy?` helper method:

- Define an `ascending` flag set to false

- Define a `descending` flag set to false

- Define variable `digits` to reference converting integer to an array of digits

- Iterate through digit array for each consecutive pair of nums

- if the left num is less than the right num, switch `ascending` flag to true

- elsif the left num is greater than the right num, switch `descending` flag to true

- Return true if both `ascending` and `descending` flags are true

  

Kyle

  

Test each number within given list / array. For each number...

1. Convert number from integer to string

2. If the number string is 2 characters or shorter, it is not a bouncy number

3. If the number string is 3 characters or longer (else statement), then iterate through each character in string, starting with the second character

a Compare the character to the preceding character

b If it is greater, then set ascending flag to true

c If it is lesser, then set descending flag to true

d If both ascending and descending flags are true, then we can stop iterating through the digits of this number, because it is a bouncy number

e If we get to the end of all the digits of the number string, the number is bouncy only if both flags are true

4. Save that number as "bouncy" or true back in our list / array

5. Return a count of the number of "bouncy" or "true"s in our list / array

  

Larry

  

- Helper function: `is_bouncy(number)` --> True if bouncy, False otherwise

- Convert to str and check length:

- If the number has 2 or fewer digits --> False

- Set `asc_flag` and desc_flag to False

- While not `asc_flag` and not desc_flag:

- Iterate over the characters in the string and compare with

the previous one.

- If first is lower than second, set desc_flag to True

- If second is lower than first, set asc_flag to True

- Return True

- main function:

- iterate over the numbers in the list and call the helper

- count the number of True

  

Josh

  

- Define an `is_bouncy?` helper method to determine if a number is bouncy

- Count number of bouncy nums in array

  

`is_bouncy?` helper method:

- Define an `ascending` flag set to false

- Define a `descending` flag set to false

- Define variable `digits` to reference converting integer to an array of digits

- Iterate through digit array for each consecutive pair of nums

- if the left num is less than the right num, switch `ascending` is_ascending() flag to true

- elsif the left num is greater than the right num, switch `descending` flag to true

is_same()

continue

- Return true if both `ascending` and `descending` flags are true

Python test cases:

print(bouncyCount([]) == 0)

print(bouncyCount([11, 0, 345, 21]) == 0)

print(bouncyCount([121, 4114]) == 2)

print(bouncyCount([176, 442, 80701644]) == 2)

  

Ruby test cases:

p bouncyCount([]) == 0

p bouncyCount([11, 0, 345, 21]) == 0

p bouncyCount([121, 4114]) == 2

p bouncyCount([176, 442, 80701644]) == 2

  

Say what you are achieving, not what you are typing

  

Test frequently

  

Use the REPL

*/