class Pazzle
  property input : Array(String) = File.read("input").split("\n")
  property increases = 0

  def window_sum(i)
    input[i].to_i + input[i + 1].to_i + input[i + 2].to_i
  rescue IndexError
    0
  end

  def solve
    input.each_with_index do |line, i|
      @increases += 1 if window_sum(i) < window_sum(i + 1)
    end

    p increases
  end
end

Pazzle.new.solve
