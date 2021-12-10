class Pazzle
  property input : Array(String) = File.read_lines("input")
  property map, points
  property size_x : Int32
  property size_y : Int32


  def initialize
    @size_y = input.size
    @size_x = input.first.size

    @map = Array(Array(Int32)).new
    size_y.times do
      @map.push  Array(Int32).new(size_x, 0)
    end

    input.each_with_index do |row, y|
      row.each_char_with_index do |val, x|
        map[y][x] = val.to_i
      end
    end

    @points = Array(Int32).new
  end

  def solve
    map.each_with_index do |row, y|
      row.each_with_index do |val, x|
        next if y > 0 && map[y - 1][x] <= val
        next if y < (size_y - 1) && map[y + 1][x] <= val
        next if x > 0 && map[y][x - 1] <= val
        next if x < (size_x - 1) && map[y][x + 1] <= val

        points.push val
      end
    end

    p points.sum + points.size
  end
end

Pazzle.new.solve
