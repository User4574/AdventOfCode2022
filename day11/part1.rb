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

  def turn
    @inspections += @items.count
    ret = []
    until @items.empty?
      old = @items.shift
      new = eval(@op) / 3
      ret << [(new % @test == 0 ? @iftrue : @iffalse), new]
    end
    ret
  end
end

class Game
  def initialize
    @monkeys = []
  end

  def <<(monkey)
    @monkeys << monkey
  end

  def round
    @monkeys.each do |monkey|
      monkey.turn.each do |tom, val|
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
lines.each_slice(6) do |mkls|
  items = mkls[1].scan(/\d+/).map(&:to_i)
  op = mkls[2].split(" = ")[1]
  test = mkls[3].scan(/\d+/)[0].to_i
  ift = mkls[4].scan(/\d+/)[0].to_i
  iff = mkls[5].scan(/\d+/)[0].to_i
  game << Monkey.new(items, op, test, ift, iff)
end

20.times do
  game.round
end
puts game.inspections.max(2).inject(&:*)
