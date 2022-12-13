def compare(left, right)
  if left.is_a?(Numeric) && right.is_a?(Numeric)
    left <=> right
  elsif left.is_a?(Array) && right.is_a?(Array)
    i = 0
    t = nil
    loop do
      if left[i].nil? && right[i].nil?
        t = 0
        break
      elsif left[i].nil?
        t = -1
        break
      elsif right[i].nil?
        t = 1
        break
      else
        t = compare(left[i], right[i])
        if t == 0
          i += 1
        else
          break
        end
      end
    end
    return t
  elsif left.is_a?(Array) && right.is_a?(Numeric)
    return compare(left, [right])
  elsif left.is_a?(Numeric) && right.is_a?(Array)
    return compare([left], right)
  end
end

packets = $stdin.readlines.map(&:strip).reject(&:empty?).map{ |l| eval(l) } + [[[2]], [[6]]]

packets.sort! do |left, right|
  compare(left, right)
end

puts (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
