class Range
  def overlap?(other)
    cover?(other.first) || other.cover?(first)
  end
end

pairs = $stdin.readlines.map { |line|
  line.strip.split(?,).map { |range|
    Range.new(*range.split(?-).map(&:to_i))
  }
}

puts pairs.select { |a, b|
  a.overlap?(b)
}.count
