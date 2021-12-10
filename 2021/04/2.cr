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
  property score = 0

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
        hits.push(Hit.new(current_board, num.to_i, i, current_row))
      end

      current_row += 1
    end
  end

  def draw(num)
    hits.select { |hit| hit.value == num }.each { |hit|hit.marked = true }
  end

  def check_winner(num)
    hits.select { |hit| hit.marked == true }.group_by { |hit| hit.board }.each do |board, data|
        win(board, num) && next if data.group_by { |hit| hit.x }.any? { |num, data| data.size == 5 }
        win(board, num) if data.group_by { |hit| hit.y }.any? { |num, data| data.size == 5 }
    end
  end

  def win(board, num)
    @score = hits.select { |hit| hit.board == board && hit.marked == false }.sum { |hit| hit.value } * num

    hits.reject! { |hit| hit.board == board }
  end

  def find_winner
    bingos.each do |num|
      draw(num)
      check_winner(num)
    end
  end

  def solve
    find_winner
    p score
  end
end

Pazzle.new.solve
