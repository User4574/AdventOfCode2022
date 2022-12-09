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
    if    head.x == @x - 1 && head.y == @y + 2
      @x -= 1
      @y += 1
    elsif head.x == @x     && head.y == @y + 2
      @y += 1
    elsif head.x == @x + 1 && head.y == @y + 2
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

    elsif head.x == @x + 1 && head.y == @y - 2
      @x += 1
      @y -= 1
    elsif head.x == @x     && head.y == @y - 2
      @y -= 1
    elsif head.x == @x - 1 && head.y == @y - 2
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

head = Pos.new
tail = Pos.new
visited = [tail.coord]

moves.each do |dir, dist|
  dist.to_i.times do
    head.move(dir)
    tail.follow(head)
    visited << tail.coord
  end
end

puts visited.uniq.count
