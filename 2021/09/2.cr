class Pazzle
  property input : Array(String) = File.read_lines("input")
  property map, points, basins
  property size_x : Int32
  property size_y : Int32
  property sum : Int32 = 0


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

    @basins = Array(Int32).new
  end

  def low_points
    map.each_with_index do |row, y|
      row.each_with_index do |val, x|
        next if y > 0 && map[y - 1][x] <= val
        next if y < (size_y - 1) && map[y + 1][x] <= val
        next if x > 0 && map[y][x - 1] <= val
        next if x < (size_x - 1) && map[y][x + 1] <= val

        @sum = 0
        basins.push(basin(x, y))
      end
    end
  end

  def basin(x, y)
    return 0 if map[y][x] == 9

    map[y][x] = 9
    @sum += 1

    basin(x, y - 1) if y > 0
    basin(x, y + 1) if y < (size_y - 1)
    basin(x - 1, y) if x > 0
    basin(x + 1, y) if x < (size_x - 1)

    return sum
  end

  def solve
    low_points

    p basins.sort.pop(3).product
  end
end

Pazzle.new.solve
# 1317792