class Pazzle
  property input : Array(String) = File.read_lines("input")

  def parse_line(line)
    patterns, outputs = line.split("|")
    patterns = patterns.strip.split(" ")
    outputs = outputs.strip.split(" ")

    return patterns, outputs
  end

  def solve
    count = 0

    input.each do |line|
      patterns, outputs = parse_line(line)

      outputs.each do |output|
        count += 1 if [2,3,4,7].includes? output.size
      end
    end

    p count
  end
end

Pazzle.new.solve
