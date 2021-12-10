class Pazzle
  property input : Array(String) = File.read("input").split(",")
  property days : Array(Int32) = Array.new(9, 0)

  def initialize
    input.each do |age|
      days[age.to_i] += 1.to_u64
    end
  end

  def live_a_day
    @days = [days[1], days[2], days[3], days[4], days[5], days[6], days[0] + days[7], days[8], days[0]]
  end

  def solve
    80.times { live_a_day }

    p days.sum
  end
end

Pazzle.new.solve
