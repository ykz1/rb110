statement = "The Flintstones Rock"

a = statement.chars.uniq.each_with_object({}) { |char, output| output[char] = statement.count(char) }

p a