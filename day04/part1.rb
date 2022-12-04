pairs = $stdin.readlines.map { |line|
  line.strip.split(?,).map { |range|
    Range.new(*range.split(?-).map(&:to_i))
  }
}

puts pairs.select { |a, b|
  a.cover?(b) || b.cover?(a)
}.count
