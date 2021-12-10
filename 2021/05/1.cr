class Pazzle
  class Line
    property x1, y1, x2, y2 : Int32

    def initialize(@x1 : Int32, @y1 : Int32, @x2 : Int32, @y2 : Int32)
    end
  end

  property map
  property input : Array(String) = File.read_lines("input")
  property lines

  def srg(rg, i)
    rg.try &.[i].to_i || 0
  end

  def initialize
    @lines = Array(Line).new
    # @map = Array(Array(Int32)).new(10, Array(Int32).new(10, 0))
    @map = Array(Array(Int32)).new
    size = 1000
    (0..size).each do |x|
      @map.push  Array(Int32).new(size, 0)
    end

    input.each do |row|
      rg = /(\d+),(\d+) -> (\d+),(\d+)/.match(row)
      @lines.push(Line.new(srg(rg, 1), srg(rg, 2), srg(rg, 3), srg(rg, 4)))
    end
  end

  def add_point(x, y)
    map[y][x] += 1
  end

  def print_map
    map.each do |row|
      p row
    end
  end

  def drow_line(line)
    if line.x1 > line.x2
      x1 = line.x2
      x2 = line.x1
    else
      x1 = line.x1
      x2 = line.x2
    end

    if line.y1 > line.y2
      y1 = line.y2
      y2 = line.y1
    else
      y1 = line.y1
      y2 = line.y2
    end

    (x1..x2).each do |x|
      (y1..y2).each do |y|
        add_point(x, y)
      end
    end
  end

  def only_vh
    lines.select { |line| line.x1 == line.x2 || line.y1 == line.y2 }
  end

  def solve
    only_vh.each do |line|
      drow_line(line)
    end

    total = 0

    map.each do |row|
      row.each do |point|
        total += 1 if point > 1
      end
    end

    p total
  end
end

Pazzle.new.solve
#6225

