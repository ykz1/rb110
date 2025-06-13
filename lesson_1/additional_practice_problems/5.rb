flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each_with_index { |name, idx| p idx if (name[0, 2] == 'Be') }
p flintstones.index { |name| name[0, 2] == 'Be' }