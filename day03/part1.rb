def priority(ch)
  if ch >= ?a && ch <= ?z
    ch.ord - 96
  elsif ch >= ?A && ch <= ?Z
    ch.ord - 64 + 26
  end
end

backpacks = $stdin.readlines.map do |line|
  line = line.strip
  half = line.length / 2
  [line[0...half].chars, line[half..-1].chars]
end

commons = backpacks.map do |f, s|
  (f & s)[0]
end

puts commons.map{|ch|priority(ch)}.sum
