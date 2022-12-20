class Blueprint
  def initialize(line)
    id, oreore, claore, obsore, obscla, geoore, geoobs = line.scan(/\d+/).map(&:to_i)
    @id = id
    @ore = {
      ore: oreore
    }
    @clay = {
      ore: claore
    }
    @obsidian = {
      ore: obsore,
      clay: obscla
    }
    @geode = {
      ore: geoore,
      obsidian: geoobs
    }
  end

  attr_reader :id

  def make_robot?(pool)
    if pool[:obsidian] >= @geode[:obsidian]
      if pool[:ore] >= @geode[:ore]
        pool[:ore] -= @geode[:ore]
        pool[:obsidian] -= @geode[:obsidian]
        return :geode
      else
        return false
      end
    end
    if pool[:clay] >= @obsidian[:clay]
      if pool[:ore] >= @obsidian[:ore]
        pool[:ore] -= @obsidian[:ore]
        pool[:clay] -= @obsidian[:clay]
        return :obsidian
      else
        return false
      end
    end
    if pool[:ore] >= @clay[:ore]
      pool[:ore] -= @clay[:ore]
      return :clay
    end
    if pool[:ore] >= @ore[:ore]
      pool[:ore] -= @ore[:ore]
      return :ore
    end
    return false
  end
end

blueprints = $stdin.readlines.map{ |line| Blueprint.new(line) }
time_limit = 24

pool = {
  ore: 0,
  clay: 0,
  obsidian: 0,
  geode: 0
}

robots = {
  ore: 1,
  clay: 0,
  obsidian: 0,
  geode: 0
}

time_limit.times do
  new_robot = blueprints[0].make_robot?(pool)

  pool[:ore] += robots[:ore]
  pool[:clay] += robots[:clay]
  pool[:obsidian] += robots[:obsidian]
  pool[:geode] += robots[:geode]

  robots[new_robot] += 1 if new_robot
end

pp pool[:geode]
