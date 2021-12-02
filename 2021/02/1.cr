class Pazzle
  property input : Array(String) = File.read("input").split("\n")
  property position : Int32 = 0
  property depth : Int32 = 0

  def solve
    input.each do |line|
      rg = /(\w+) (\d+)/.match(line)
      command = rg.try &.[1]
      value : Int32 = rg.try &.[2].to_i || 0

      case command
      when "forward"
        @position += value
      when "down"
        @depth += value
      when "up"
        @depth -= value
      end
    end

    p position * depth
  end
end

Pazzle.new.solve
