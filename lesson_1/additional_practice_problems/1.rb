flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

hash = flintstones.each_with_object({}).with_index { |(name, hash), idx| hash[idx] = name }
p hash