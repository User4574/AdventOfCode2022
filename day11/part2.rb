class Monkey
  def initialize(items, op, test, iftrue, iffalse)
    @items = items
    @op = op
    @test = test
    @iftrue = iftrue
    @iffalse = iffalse
    @inspections = 0
  end

  attr_reader :items, :inspections

  def <<(item)
    @items << item
  end

  def turn(wl)
    @inspections += @items.count
    ret = []
    until @items.empty?
      old = @items.shift
      new = eval(@op) % wl
      ret << [(new % @test == 0 ? @iftrue : @iffalse), new]
    end
    ret
  end
end

class Game
  def initialize
    @monkeys = []
    @worry_limit = 1
  end

  attr_accessor :worry_limit

  def <<(monkey)
    @monkeys << monkey
  end

  def round
    @monkeys.each do |monkey|
      monkey.turn(@worry_limit).each do |tom, val|
        @monkeys[tom] << val
      end
    end
  end

  def inspections
    @monkeys.map(&:inspections)
  end
end

lines = $stdin.readlines.map(&:strip).reject(&:empty?)

game = Game.new
wl = 1
lines.each_slice(6) do |mkls|
  items = mkls[1].scan(/\d+/).map(&:to_i)
  op = mkls[2].split(" = ")[1]
  test = mkls[3].scan(/\d+/)[0].to_i
  wl *= test
  ift = mkls[4].scan(/\d+/)[0].to_i
  iff = mkls[5].scan(/\d+/)[0].to_i
  game << Monkey.new(items, op, test, ift, iff)
end
game.worry_limit = wl

10_000.times do |i|
  game.round
end
puts game.inspections.max(2).inject(&:*)
