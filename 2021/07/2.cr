class Pazzle
  property input : Array(Int32) = File.read("input").split(",").map { |i| i.to_i }.sort

  def solve
    pos = 0
    min = 100000000000

    while pos < input.size
      result = 0

      input.each do |start|
        target = (start-pos).abs
        result += target * (target + 1) / 2
      end

      min = result if result < min

      pos += 1
    end

    p min
  end
end

Pazzle.new.solve
