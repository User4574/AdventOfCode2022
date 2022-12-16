class Valve
  def initialize(flow_rate, tunnels)
    @flow_rate = flow_rate
    @tunnels = tunnels
    @distance = {}
    @open = false
  end

  attr_reader :flow_rate, :tunnels, :distance

  def open?
    @open
  end

  def open!
    @open = true
  end
end

valves = {}
$stdin.readlines.each do |line|
  fr = line.scan(/\d+/)[0].to_i
  name, *tunnels = line.scan(/[A-Z]{2}/)
  valves[name] = Valve.new(fr, tunnels)
end

valves.each do |k, v|
  seen = [k]
  v.distance[k] = 0
  q = v.tunnels.map{|nv|[nv, 1]}
  until q.empty?
    nv, d = q.shift
    seen << nv
    v.distance[nv] = d if v.distance[nv].nil?
    q += valves[nv].tunnels.reject{ |t| seen.include?(t) }.map{ |nv| [nv, d+1] }
  end
end

pointful_valves = valves.select { |k, v| v.flow_rate != 0 }.keys

at = "AA"
time_rem = 30
relief = 0

loop do
  nv = nil
  pointful_valves.each do |this|
    next if valves[this].open?
    nv = this if pointful_valves.map { |that|
      (
        valves[that].open? ?
          0 :
          (valves[at].distance[this] - valves[at].distance[that] + 1) *
            valves[that].flow_rate - valves[this].flow_rate
      ) <= 0
    }.all?
  end

  break if nv.nil?
  time_rem -= valves[at].distance[nv]
  time_rem -= 1
  break if time_rem < 0
  puts nv
  puts time_rem
  valves[nv].open!
  relief += (time_rem * valves[nv].flow_rate)
  at = nv
end

pp relief

exit


num_valves = pointful_valves.count

max_relief = 0

pointful_valves.permutation.each do |order|
  at = "AA"
  num_open = 0
  time_rem = 30
  relief = 0
  until time_rem < 0 || num_open == num_valves
    nv = order.shift
    time_rem -= valves[at].distance[nv]
    time_rem -= 1
    relief += time_rem * valves[nv].flow_rate
    at = nv
    num_open += 1
  end
  max_relief = relief if relief > max_relief
end

puts max_relief
