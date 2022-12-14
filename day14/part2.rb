solids = []

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
      (y1..y2).each { |y| solids << [x, y] }
    else
      x1 = path[i][0]
      x2 = path[i+1][0]
      if x1 > x2
        t = x2
        x2 = x1
        x1 = t
      end
      y = path[i][1]
      (x1..x2).each { |x| solids << [x, y] }
    end
  }
}

solids.uniq!

floor = solids.map{ |_, y| y }.max + 1

sands = 0
loop do
  puts sands
  sand = [500, 0]
  loop do
    if sand[1] == floor
      break
    else
      if solids.include?([sand[0], sand[1] + 1])
        if solids.include?([sand[0] - 1, sand[1] + 1])
          if solids.include?([sand[0] + 1, sand[1] + 1])
            break
          else
            sand = [sand[0] + 1, sand[1] + 1]
          end
        else
          sand = [sand[0] - 1, sand[1] + 1]
        end
      else
        sand = [sand[0], sand[1] + 1]
      end
    end
  end
  solids << sand
  sands += 1
  break if sand == [500, 0]
end

puts sands
