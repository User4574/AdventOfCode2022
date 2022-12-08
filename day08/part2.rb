def score_up(grid, ri, ci)
  tree = grid[ri][ci]
  vis = 0
  loop do
    ri -= 1
    break if ri < 0
    vis += 1
    break if grid[ri][ci] >= tree
  end
  vis
end

def score_down(grid, ri, ci)
  tree = grid[ri][ci]
  vis = 0
  loop do
    ri += 1
    break if ri >= grid.count
    vis += 1
    break if grid[ri][ci] >= tree
  end
  vis
end

def score_left(grid, ri, ci)
  tree = grid[ri][ci]
  vis = 0
  loop do
    ci -= 1
    break if ci < 0
    vis += 1
    break if grid[ri][ci] >= tree
  end
  vis
end

def score_right(grid, ri, ci)
  tree = grid[ri][ci]
  vis = 0
  loop do
    ci += 1
    break if ci >= grid[ri].count
    vis += 1
    break if grid[ri][ci] >= tree
  end
  vis
end

grid = $stdin.readlines.map(&:strip).map(&:chars).map { |row| row.map(&:to_i) }

max_score = 0

grid.count.times do |ri|
  grid[ri].count.times do |ci|
    score = 1
    score *= score_up(grid, ri, ci)
    score *= score_down(grid, ri, ci)
    score *= score_left(grid, ri, ci)
    score *= score_right(grid, ri, ci)
    max_score = score if score > max_score
  end
end

puts max_score
