def mutate(eqn, tgt)
  if eqn[6..9] == tgt
    op = case eqn[11]
    when ?+; ?-
    when ?-; ?+
    when ?*; ?/
    when ?/; ?*
    end
    "#{eqn[6..9]}: #{eqn[0..3]} #{op} #{eqn[13..16]}"
  else
    case eqn[11]
    when ?+
      "#{eqn[13..16]}: #{eqn[0..3]} - #{eqn[6..9]}"
    when ?-
      "#{eqn[13..16]}: #{eqn[6..9]} - #{eqn[0..3]}"
    when ?*
      "#{eqn[13..16]}: #{eqn[0..3]} / #{eqn[6..9]}"
    when ?/
      "#{eqn[13..16]}: #{eqn[6..9]} / #{eqn[0..3]}"
    end
  end
end

monkeys = $stdin.readlines.reject { |l| l[0...4] == "humn" }

prev = nil
need = "humn"
loop do
  cand = monkeys.
          select { |m| m.include?(need) }.
          reject { |m| m[0...4] == prev }[0]
  cix = monkeys.find_index(cand)
  break if cand[0...4] == "root"
  monkeys[cix] = mutate(cand, need)
  prev = need
  need = cand[0...4]
end

root = monkeys.select { |m| m[0...4] == "root" }[0]
candname = (root[6..9] == need ? root[13..16] : root[6..9])
monkeys.delete(root)

cand = monkeys.select { |m| m[0...4] == candname }[0]
cix = monkeys.index(cand)
monkeys[cix] = "#{need}#{cand[4..16]}"

nums = {}

monkeys.count.times do |mix|
  if monkeys[mix] =~ /(\d+)/
    val = $1.to_i
    nums[monkeys[mix][0...4]] = $1.to_i
    monkeys[mix] = nil
  end
end
monkeys.compact!

while nums["humn"].nil?
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

puts nums["humn"]
