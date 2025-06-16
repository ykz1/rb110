HEX = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

def generate_uuid
  output = ''
  [8, 4, 4, 4, 12].map do |length|
    (1..length).map { |_| HEX.sample }.join
  end.join('-')
end

p generate_uuid