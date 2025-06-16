munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


males = munsters.select { |_, traits| traits['gender'] == 'male' }
male_ages = males.values.map { |traits| traits['age'] }
total_male_age = male_ages.sum
average_male_age =  male_ages.sum / male_ages.count

p total_male_age
p average_male_age