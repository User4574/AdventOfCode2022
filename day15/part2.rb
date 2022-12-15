class Sensor
  def initialize(sx, sy, bx, by)
    @x = sx
    @y = sy
    @range = dist(bx, by)
  end

  attr_reader :x, :y, :range

  def dist(x, y)
    (@x - x).abs + (@y - y).abs
  end

  def cover?(x, y)
    dist(x, y) <= @range
  end

  def edge
    edges = []
    atx = @x
    aty = @y - (@range + 1)
    until aty == @y
      edges << [atx, aty]
      atx += 1
      aty += 1
    end
    until atx == @x
      edges << [atx, aty]
      atx -= 1
      aty += 1
    end
    until aty == @y
      edges << [atx, aty]
      atx -= 1
      aty -= 1
    end
    until atx == @x
      edges << [atx, aty]
      atx += 1
      aty -= 1
    end
    edges
  end
end

sensors = []
$stdin.readlines.each do |line|
  c = line.scan(/x=(-?\d+), y=(-?\d+)/).flatten.map(&:to_i)
  sensors << Sensor.new(*c)
end

max = 4_000_000

coord = sensors.map { |s|
  s.edge.reject { |e|
    e[0] < 0 || e[0] > max ||
    e[1] < 0 || e[1] > max ||
    sensors.any? { |s2| s2.cover?(*e) }
  }
}.flatten(1).uniq[0]

puts coord[0] * 4_000_000 + coord[1]
