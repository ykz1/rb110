a = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

b = a.map do |hsh|
  hsh.map { |k, v| [k, v + 1] }.to_h
end

p b == [{a: 2}, {b: 3, c: 4}, {d: 5, e: 6, f: 7}]