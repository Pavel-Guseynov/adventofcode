class Pazzle
  property input : Array(String) = File.read_lines("input")

  def parse_line(line)
    patterns, outputs = line.split("|")
    patterns = patterns.strip.split(" ").map { |p| p.chars.sort }
    outputs = outputs.strip.split(" ").map { |p| p.chars.sort.join }

    return patterns, outputs
  end

  def get_dict(patterns)
    dict = Hash(Int32, Array(Char)).new

    dict[1] = patterns.find(Array(Char).new) { |p| p.size == 2 }
    dict[4] = patterns.find(Array(Char).new) { |p| p.size == 4 }
    dict[8] = patterns.find(Array(Char).new) { |p| p.size == 7 }
    dict[7] = patterns.find(Array(Char).new) { |p| p.size == 3 }

    dict[9] = patterns.find(Array(Char).new) { |p| p.size == 6 && (p & dict[4]).size == 4 }
    dict[0] = patterns.find(Array(Char).new) { |p| p.size == 6 && (p & dict[7]).size == 3 && p != dict[9] }
    dict[6] = patterns.find(Array(Char).new) { |p| p.size == 6 && p != dict[9] && p != dict[0] }
    dict[5] = patterns.find(Array(Char).new) { |p| p.size == 5 && (p & dict[6]).size == 5 }
    dict[3] = patterns.find(Array(Char).new) { |p| p.size == 5 && (p & dict[4]).size == 3 && p != dict[5] }
    dict[2] = patterns.find(Array(Char).new) { |p| p.size == 5 && p != dict[5] && p != dict[3] }

    return dict
  end

  def solve
    sum = 0

    input.each do |line|
      patterns, outputs = parse_line(line)

      dict = get_dict(patterns)

      result = ""

      outputs.each do |output|
        dict.each do |k,v|
          result += k.to_s if v.join == output
        end
      end

      sum += result.to_i
    end

    p sum
  end
end

Pazzle.new.solve