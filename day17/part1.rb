jets = $stdin.read.strip.chars
jetp = 0
njets = jets.count

rocks = [
  [ 1|2|4|8              ],
  [ 2,       1|2|4, 2    ],
  [ 1|2|4,   4,     4    ],
  [ 1,       1,     1, 1 ],
  [ 1|2,     1|2         ]
]
rockp = 0
nrocks = rocks.count

def rock_blocked(atx, aty, chamber, rock)
  return true if atx < 0 || aty < 0

  return true if rock.map{|row|row << atx}.any?{|row|row > 127}

  rock.each_with_index do |rxs, ry|
    next if chamber[aty + ry].nil?
    return true if (chamber[aty + ry] & (rxs << atx)) != 0
  end

  return false
end

chamber = []

2022.times do
  atx = 2
  aty = chamber.count + 3

  rock = rocks[rockp]
  rockp = (rockp + 1) % nrocks

  loop do
    case jets[jetp]
    when ?<
      atx -= 1 unless rock_blocked(atx - 1, aty, chamber, rock)
    when ?>
      atx += 1 unless rock_blocked(atx + 1, aty, chamber, rock)
    end
    jetp = (jetp + 1) % njets

    if rock_blocked(atx, aty - 1, chamber, rock)
      rock.each_with_index do |rxs, ry|
        sy = aty + ry
        chamber[sy] = 0 if chamber[sy].nil?
        chamber[sy] |= (rxs << atx)
      end
      break
    else
      aty -= 1
    end
  end
end

puts chamber.count
