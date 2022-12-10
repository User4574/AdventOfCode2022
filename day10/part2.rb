class CPU
  def initialize
    @x = 1
    @cycle = 1
    @iq = []
  end

  attr_reader :x, :cycle

  def enq(op, arg = 0)
    @iq << [
      arg,
      case op
      when 'noop'; 1
      when 'addx'; 2
      end
    ]
  end

  def done?
    @iq.empty?
  end

  def clock
    istr = @iq[0]
    istr[1] -= 1
    if istr[1] == 0
      @x += istr[0]
      @iq.shift
    end
    @cycle += 1
  end
end

cpu = CPU.new

istrs = $stdin.readlines.map(&:strip).map(&:split)
istrs.each do |istr|
  cpu.enq(istr[0], istr[1]&.to_i || 0)
end

until cpu.cycle == 241
  hp = (cpu.cycle - 1) % 40
  px = (hp - cpu.x).abs < 2

  print px ? ?█ : ?\s
  puts if hp == 39

  cpu.clock
end
