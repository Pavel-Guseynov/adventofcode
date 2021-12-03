class Pazzle
  property input : Array(String) = File.read("input").split("\n")
  property positive = Array(String).new
  property zeros = Array(String).new
  property source = Array(String).new

  def for_row(source, i)
    @positive = Array(String).new
    @zeros = Array(String).new

    source.each do |line|
      if line[i] == '1'
        @positive.push(line)
      else
        @zeros.push(line)
      end
    end
  end

  def for_sign(max)
    for_row(input, 0)

    (1..12).to_a.each do |i|
      if positive.size == zeros.size
        @source = positive if max
        @source = zeros unless max
      elsif positive.size > zeros.size
        @source = positive if max
        @source = zeros unless max
      else
        @source = zeros if max
        @source = positive unless max
      end

      break if source.size == 1

      for_row(source, i)
    end

    return source.first.to_i(2)
  end

  def solve
    ogr = for_sign(true)
    csr = for_sign(false)

    p ogr * csr
  end
end

Pazzle.new.solve
