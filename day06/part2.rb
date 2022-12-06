input = $stdin.read.strip.chars

somm = 0

until input[somm, 14].uniq.count == 14 do
  somm += 1
end

puts somm + 14
