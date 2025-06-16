hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# Output all vowels from the strings using #each

output = ''

hsh.each do |_, v| 
  v.each do |str|
    str.chars.each do |char|
      output << char if 'aeiouAEIOU'.include?(char)
    end
  end
end

p output