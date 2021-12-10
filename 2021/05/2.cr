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
    dx = line.x2-line.x1
    dy = line.y2-line.y1

    r =  Math.max(dx.abs, dy.abs)

    i = 0

    while i <= r
      xm = if dx > 0
        1
      elsif dx < 0
          -1
      else
        0
       end

      ym = if dy > 0
        1
      elsif dy < 0
        -1
      else
        0
      end

      x = line.x1 + xm * i
      y = line.y1 + ym * i

      add_point(x, y)

      i += 1
    end
  end

  def solve
    lines.each do |line|
      drow_line(line)
    end

    total = 0

    map.each do |row|
      row.each do |point|
        total += 1 if point > 1
      end
    end

    # print_map

    p total
  end
end

Pazzle.new.solve
