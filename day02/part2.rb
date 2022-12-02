def whatplay(them, outcome)
  case them
  when 1
    case outcome
    when 0; 3
    when 3; 1
    when 6; 2
    end
  when 2
    case outcome
    when 0; 1
    when 3; 2
    when 6; 3
    end
  when 3
    case outcome
    when 0; 2
    when 3; 3
    when 6; 1
    end
  end
end

rounds = $stdin.readlines.map(&:strip).map(&:split)

score = 0

rounds.each do |them, outcome|
  ti = {?A => 1, ?B => 2, ?C => 3}[them]
  oi = {?X => 0, ?Y => 3, ?Z => 6}[outcome]
  score += whatplay(ti, oi)
  score += oi
end

puts score
