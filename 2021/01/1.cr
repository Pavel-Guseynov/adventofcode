class Pazzle
  property input : Array(String) = File.read("input").split("\n")
  property last = 0
  property increases = -1

  def solve
    input.each do |line|
      current = line.to_i

      @increases += 1 if last < current

      @last = current
    end

    p increases
  end
end

Pazzle.new.solve
