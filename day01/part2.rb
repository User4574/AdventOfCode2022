items = $stdin.readlines.map(&:strip)
elves = []

sum = 0
items.each do |item|
  if item.empty?
    elves << sum
    sum = 0
  else
    sum += item.to_i
  end
end
elves << sum

puts elves.max(3).sum
