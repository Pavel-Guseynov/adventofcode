class Pazzle
  property input : Array(String) = File.read("input").split("\n")
  property positive : Array(Int32) = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

  def solve
    input.each do |line|
      line.each_char_with_index do |char, i|
        positive[i] += 1 if char == '1'
      end
    end

    gamma : String = ""
    epsilon : String = ""

    positive.each_with_index do |num, i|
      gamma += num > 500 ? '1' : '0'
      epsilon += num < 500 ? '1' : '0'
    end

    p gamma.to_i(2) * epsilon.to_i(2)
  end
end

Pazzle.new.solve
