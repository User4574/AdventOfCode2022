def check_up(grid, ri, ci)
  tree = grid[ri][ci]
  loop do
    ri -= 1
    break if ri < 0
    return false unless grid[ri][ci] < tree
  end
  true
end

def check_down(grid, ri, ci)
  tree = grid[ri][ci]
  loop do
    ri += 1
    break if ri >= grid.count
    return false unless grid[ri][ci] < tree
  end
  true
end

def check_left(grid, ri, ci)
  tree = grid[ri][ci]
  loop do
    ci -= 1
    break if ci < 0
    return false unless grid[ri][ci] < tree
  end
  true
end

def check_right(grid, ri, ci)
  tree = grid[ri][ci]
  loop do
    ci += 1
    break if ci >= grid[ri].count
    return false unless grid[ri][ci] < tree
  end
  true
end

grid = $stdin.readlines.map(&:strip).map(&:chars).map { |row| row.map(&:to_i) }

num_visible = 0

grid.count.times do |ri|
  grid[ri].count.times do |ci|
    visible = false
    visible = true if check_up(grid, ri, ci)
    visible = true if check_down(grid, ri, ci)
    visible = true if check_left(grid, ri, ci)
    visible = true if check_right(grid, ri, ci)
    num_visible += 1 if visible
  end
end

puts num_visible
