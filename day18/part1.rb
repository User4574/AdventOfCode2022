require 'set'

grid = Hash.new

$stdin.readlines.each do |line|
  x, y, z = line.strip.split(?,).map(&:to_i)
  grid[x] = Hash.new if grid[x].nil?
  grid[x][y] = Set.new if grid[x][y].nil?
  grid[x][y] << z
end

sa = 0

grid.each do |x, yzs|
  yzs.each do |y, zs|
    zs.each do |z|
      tsa = 6
      tsa -= 1 if !grid[x-1].nil? && grid[x-1][y]&.include?(z)
      tsa -= 1 if !grid[x+1].nil? && grid[x+1][y]&.include?(z)
      tsa -= 1 if grid[x][y-1]&.include?(z)
      tsa -= 1 if grid[x][y+1]&.include?(z)
      tsa -= 1 if grid[x][y].include?(z-1)
      tsa -= 1 if grid[x][y].include?(z+1)
      sa += tsa
    end
  end
end

puts sa
