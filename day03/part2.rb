def priority(ch)
  if ch >= ?a && ch <= ?z
    ch.ord - 96
  elsif ch >= ?A && ch <= ?Z
    ch.ord - 64 + 26
  end
end

backpacks = $stdin.readlines.map(&:strip).map(&:chars)

commons = backpacks.each_slice(3).map do |backpacks|
  backpacks.inject(:&)[0]
end

puts commons.map{|ch|priority(ch)}.sum
