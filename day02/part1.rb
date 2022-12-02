def play(them, us)
  us + case them
  when 1
    case us
    when 1; 3
    when 2; 6
    when 3; 0
    end
  when 2
    case us
    when 1; 0
    when 2; 3
    when 3; 6
    end
  when 3
    case us
    when 1; 6
    when 2; 0
    when 3; 3
    end
  end
end

rounds = $stdin.readlines.map(&:strip).map(&:split)

score = 0

rounds.each do |them, us|
  ti = {?A => 1, ?B => 2, ?C => 3}[them]
  ui = {?X => 1, ?Y => 2, ?Z => 3}[us]
  score += play(ti, ui)
end

puts score
