lines = $stdin.readlines

brk = lines.index(?\n)
stackin = lines[0..(brk-2)]
movein = lines[(brk+1)..-1]

numstacks = lines[brk-1].split[-1].to_i
stacks = Array.new(numstacks) { [] }

stackin.reverse.each do |rank|
  stack = 0
  until rank.empty? do
    stacks[stack] << rank[1] if rank[0] == ?[
    rank = rank[4..-1]
    stack += 1
  end
end

movein.each do |istr|
  n, f, t = istr.scan(/\Amove (\d+) from (\d+) to (\d+)\Z/)[0].map(&:to_i)
  stacks[t-1].push(*stacks[f-1].pop(n))
end

puts stacks.map(&:pop).join
