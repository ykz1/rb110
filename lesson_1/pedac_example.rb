# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes and 2 or more characters long.
# Consider palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

=begin
input:        string
output:       array of string elements
requirements: 
  explicit:   - substrings returned are words separated by spaces in the original string
              - include only the substrings which are palindromes
              - palindromes are case sensitive "Dad" is not one but "dad" is
              - palindromes should have 2 or more characters
  implicit:   - if no palindromes are found, return an empty array
              - return a new array object

NOTE: ^ above understanding of substring is incorrect...not looking for words but combination of characters (length >= 2) formed by original string.
=end