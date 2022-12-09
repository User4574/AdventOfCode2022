class Pos
  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  attr_reader :x, :y

  def move(dir)
    case dir
    when "U"
      @y += 1
    when "D"
      @y -= 1
    when "R"
      @x += 1
    when "L"
      @x -= 1
    end
  end

  def follow(head)
    if    head.x == @x - 2 && head.y == @y + 2
      @x -= 1
      @y += 1
    elsif head.x == @x - 1 && head.y == @y + 2
      @x -= 1
      @y += 1
    elsif head.x == @x     && head.y == @y + 2
      @y += 1
    elsif head.x == @x + 1 && head.y == @y + 2
      @x += 1
      @y += 1

    elsif head.x == @x + 2 && head.y == @y + 2
      @x += 1
      @y += 1
    elsif head.x == @x + 2 && head.y == @y + 1
      @x += 1
      @y += 1
    elsif head.x == @x + 2 && head.y == @y
      @x += 1
    elsif head.x == @x + 2 && head.y == @y - 1
      @x += 1
      @y -= 1

    elsif head.x == @x + 2 && head.y == @y - 2
      @x += 1
      @y -= 1
    elsif head.x == @x + 1 && head.y == @y - 2
      @x += 1
      @y -= 1
    elsif head.x == @x     && head.y == @y - 2
      @y -= 1
    elsif head.x == @x - 1 && head.y == @y - 2
      @x -= 1
      @y -= 1

    elsif head.x == @x - 2 && head.y == @y - 2
      @x -= 1
      @y -= 1
    elsif head.x == @x - 2 && head.y == @y - 1
      @x -= 1
      @y -= 1
    elsif head.x == @x - 2 && head.y == @y
      @x -= 1
    elsif head.x == @x - 2 && head.y == @y + 1
      @x -= 1
      @y += 1
    end
  end

  def coord
    [@x, @y]
  end
end

moves = $stdin.readlines.map(&:strip).map(&:split)

rope = Array.new(10) { Pos.new }
visited = [rope[-1].coord]

moves.each do |dir, dist|
  dist.to_i.times do
    rope[0].move(dir)
    (rope.length - 1).times do |i|
      rope[i+1].follow(rope[i])
    end
    visited << rope[-1].coord
  end
end

puts visited.uniq.count
