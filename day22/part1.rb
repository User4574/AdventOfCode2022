def consume(path)
  case path[0]
  when ?L
    [?L, path[1..-1]]
  when ?R
    [?R, path[1..-1]]
  when /\d/
    act = path.chars.take_while { |ch| ch =~ /\d/ }.join
    l = act.length
    [act.to_i, path[l..-1]]
  end
end

input = $stdin.readlines.map(&:rstrip)
map = input[0..-3]
path = input[-1]

r = 0
c = input[0].index(?.)
d = ?R

until path.empty?
  action, path = consume(path)
  case action
  when ?L
    d = case d
    when ?U; ?L
    when ?R; ?U
    when ?D; ?R
    when ?L; ?D
    end
  when ?R
    d = case d
    when ?U; ?R
    when ?R; ?D
    when ?D; ?L
    when ?L; ?U
    end
  else
    action.times do
      case d
      when ?U
        nr = r - 1
        if nr < 0 || map[nr][c] == ?\s || map[nr][c].nil?
          nr = map.length - 1
          nr -= 1 until map[nr][c] == ?. || map[nr][c] == ?#
        end
        break if map[nr][c] == ?#
        r = nr
      when ?R
        nc = c + 1
        if nc >= map[r].length || map[r][nc] == ?\s || map[r][nc].nil?
          nc = 0
          nc += 1 until map[r][nc] == ?. || map[r][nc] == ?#
        end
        break if map[r][nc] == ?#
        c = nc
      when ?D
        nr = r + 1
        if nr >= map.length || map[nr][c] == ?\s || map[nr][c].nil?
          nr = 0
          nr += 1 until map[nr][c] == ?. || map[nr][c] == ?#
        end
        break if map[nr][c] == ?#
        r = nr
      when ?L
        nc = c - 1
        if nc < 0 || map[r][nc] == ?\s || map[r][nc].nil?
          nc = map[r].length - 1
          nc -= 1 until map[r][nc] == ?. || map[r][nc] == ?#
        end
        break if map[r][nc] == ?#
        c = nc
      end
    end
  end
end

puts 1000 * (r+1) + 4 * (c + 1) + case d
                                  when ?R; 0
                                  when ?D; 1
                                  when ?L; 2
                                  when ?U; 3
                                  end
