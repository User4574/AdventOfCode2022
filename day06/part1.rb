input = $stdin.read.strip.chars

sopm = 0

until input[sopm, 4].uniq.count == 4 do
  sopm += 1
end

puts sopm + 4
