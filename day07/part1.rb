lines = $stdin.readlines.map(&:strip)

class FSObj
  attr_reader :name
end

class FSDir < FSObj
  def initialize(name, parent = self)
    @name = name
    @parent = parent
    @entries = []
  end

  attr_reader :parent

  def add_entry(obj)
    @entries.push(obj)
  end

  def find_entry(name)
    @entries.select{|ent|ent.name == name}[0]
  end

  def subdirs
    @entries.select{|ent|ent.class == FSDir}
  end

  def size
    @entries.map(&:size).sum
  end
end

class FSFile < FSObj
  def initialize(name, size)
    @name = name
    @size = size
  end

  attr_reader :size
end

root = FSDir.new(?/)
current = root

lines.each do |line|
  case line
  when "$ ls"
    next
  when "$ cd /"
    next
  when "$ cd .."
    current = current.parent
  when /\A\$ cd (.+)\Z/
    current = current.find_entry($1)
  when /\Adir (.+)\Z/
    current.add_entry(FSDir.new($1, current))
  when /\A(\d+) (.+)\Z/
    current.add_entry(FSFile.new($2, $1.to_i))
  end
end

dirs = [root]
ltht = []

until dirs.empty? do
  this = dirs.shift
  ltht.push(this) if this.size < 100000
  dirs.push(*this.subdirs)
end

puts ltht.map(&:size).sum
