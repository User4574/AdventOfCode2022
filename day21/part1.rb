monkeys = $stdin.readlines

nums = {}

monkeys.count.times do |mix|
  if monkeys[mix] =~ /(\d+)/
    val = $1.to_i
    nums[monkeys[mix][0...4]] = $1.to_i
    monkeys[mix] = nil
  end
end
monkeys.compact!

while nums["root"].nil?
  monkeys.count.times do |mix|
    f, a, b = monkeys[mix].scan(/[a-z]{4}/)
    unless nums[a].nil? || nums[b].nil?
      case monkeys[mix][11]
      when ?+
        nums[f] = nums[a] + nums [b]
      when ?-
        nums[f] = nums[a] - nums [b]
      when ?*
        nums[f] = nums[a] * nums [b]
      when ?/
        nums[f] = nums[a] / nums [b]
      end
      monkeys[mix] = nil
    end
  end
  monkeys.compact!
end

puts nums["root"]
