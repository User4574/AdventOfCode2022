solids = Hash.new { |h, k| h[k] = Array.new }

$stdin.readlines.map { |line|
  line.strip.split(' -> ').map {
    |coord| coord.split(?,).map(&:to_i)
  }
}.each { |path|
  (path.length - 1).times { |i|
    if path[i][0] == path[i+1][0]
      x = path[i][0]
      y1 = path[i][1]
      y2 = path[i+1][1]
      if y1 > y2
        t = y2
        y2 = y1
        y1 = t
      end
      (y1..y2).each { |y| solids[y] << x }
    else
      x1 = path[i][0]
      x2 = path[i+1][0]
      if x1 > x2
        t = x2
        x2 = x1
        x1 = t
      end
      y = path[i][1]
      (x1..x2).each { |x| solids[y] << x }
    end
  }
}

solids.keys.each { |k| solids[k].uniq!  }

floor = solids.keys.flatten.max + 1

sands = 0
loop do
  sandx = 500
  sandy = 0

  loop do
    break if sandy == floor

    r = solids[sandy + 1]
    if r.include?(sandx)
      if r.include?(sandx - 1)
        if r.include?(sandx + 1)
          break
        else
          sandx += 1
        end
      else
        sandx -= 1
      end
    end
    sandy += 1
  end

  solids[sandy] << sandx
  sands += 1

  break if sandx == 500 && sandy == 0
end

puts sands
