class Pazzle
  class Hit
    property board, value, x, y : Int32
    property marked = false

    def initialize(@board : Int32, @value : Int32, @x : Int32, @y : Int32)
    end
  end

  property input : Array(String) = File.read_lines("input")
  property hits
  property bingos

  def initialize
    @hits = Array(Hit).new
    @bingos = Array(Int32).new

    load
  end

  def load
    @bingos = input.shift.split(',').map { |v| v.to_i }

    current_board = 0
    current_row = 0

    input.each do |line|
      if line == ""
        current_board += 1
        current_row = 0
        next
      end

      colls = line.split(' ')
      colls.delete("")
      colls.each_with_index do |num, i|
        @hits.push(Hit.new(current_board, num.to_i, i, current_row))
      end

      current_row += 1
    end
  end

  def draw(num)
    hits.select { |hit| hit.value == num }.each { |hit|hit.marked = true }
  end

  def check_winner
    hits.select { |hit| hit.marked == true }.group_by { |hit| hit.board }.each do |board, data|
      return board, data if data.group_by { |hit| hit.x }.any? { |num, data| data.size == 5 }
      return board, data if data.group_by { |hit| hit.y }.any? { |num, data| data.size == 5 }
    end

    return false, [Hit.new(0,0,0,0)] # Can't be nil
  end

  def find_winner
    bingos.each do |num|
      draw(num)
      board, data = check_winner

      p data.group_by { |hit| hit.x }
      p data

      return board, num if board
    end

    return [Hit.new(0,0,0,0)], 0 # Can't be nil
  end

  def solve
    board, num = find_winner
    p hits.select { |hit| hit.board == board && hit.marked == false }.sum { |hit| hit.value } * num
  end
end

Pazzle.new.solve
# 59940 h
