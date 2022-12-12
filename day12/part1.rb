class Node
  def initialize(height)
    @height = height
    @neighbours = []
    @visited = false
    @distance = Float::INFINITY
  end

  attr_reader :height, :neighbours

  attr_accessor :visited, :distance

  def add_neighbour(node)
    @neighbours << node
  end
end

start = nil
goal = nil

grid = $stdin.readlines.map do |line|
  line.strip.chars.map do |ch|
    n = Node.new(
      case ch
      when ?a..?z
        ch.ord - 96
      when ?S
        1
      when ?E
        26
      end
    )
    start = n if ch == ?S
    goal = n if ch == ?E
    n
  end
end

h = grid.length
w = grid[0].length

h.times.each do |rix|
  w.times.each do |cix|
    grid[rix][cix].add_neighbour(grid[rix-1][cix]) if rix - 1 >= 0
    grid[rix][cix].add_neighbour(grid[rix][cix-1]) if cix - 1 >= 0
    grid[rix][cix].add_neighbour(grid[rix+1][cix]) if rix + 1 < h
    grid[rix][cix].add_neighbour(grid[rix][cix+1]) if cix + 1 < w
  end
end

unvisited = grid.flatten
start.distance = 0

current = start

until goal.visited
  current.neighbours.select { |n|
    !n.visited &&
    (n.height - current.height) < 2
  }.each { |n|
    d = current.distance + 1
    n.distance = d if d < n.distance
  }
  current.visited = true
  unvisited.delete(current)
  current = unvisited.min{|a, b| a.distance <=> b.distance}
end

puts goal.distance
