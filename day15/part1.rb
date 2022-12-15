class Sensor
  def initialize(sx, sy, bx, by)
    @x = sx
    @y = sy
    @range = (sx - bx).abs + (sy - by).abs
  end

  attr_reader :x, :y, :range
end

sensors = []
beacons = []
$stdin.readlines.each do |line|
  c = line.scan(/x=(-?\d+), y=(-?\d+)/).flatten.map(&:to_i)
  sensors << Sensor.new(*c)
  beacons << c[2..3]
end

row = 2_000_000

xranges = []
sensors.each do |s|
  dx = s.range - (s.y - row).abs
  xranges << ((s.x - dx)..(s.x + dx)) if dx > 0
end

from = xranges.map(&:begin).min 
to = xranges.map(&:end).max
xs = to - from + 1

(from..to).each do |x|
  xs += 1 unless xranges.any? { |xrange| xrange.include?(x) }
end
xs -= beacons.select { |_, y| y == row }.map { |x, _| x }.uniq.count

pp xs
