class Pazzle
  property input : Array(Int32) = File.read("input").split(",").map { |i| i.to_i }.sort

  def solve
    target = input[input.size // 2]

    fuel = 0

    input.each do |start|
      fuel += (target - start).abs
    end

    p fuel
  end
end

Pazzle.new.solve
