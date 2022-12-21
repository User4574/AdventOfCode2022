file = $stdin.readlines.map(&:to_i)
size = file.length
pointer = 0

size.times do
  val = file[pointer]
  to = pointer + val

  file.delete_at(pointer)
  file.insert(to, val)

  pointer += 1 if to <= pointer
end
