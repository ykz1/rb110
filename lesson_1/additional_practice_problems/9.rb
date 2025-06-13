words = "the flintstones rock"
words = words.split.map { |word| word[0].upcase + word[1..-1] }.join(' ')
p words