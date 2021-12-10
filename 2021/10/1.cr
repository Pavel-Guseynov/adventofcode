class Pazzle
  property input : Array(String) = File.read_lines("input")
  property open_chars = ['(', '[', '{', '<']
  property close_chars = [')', ']', '}', '>']
  property corrupted = Array(Char).new

  def parse_line(line)
    stack = Array(Char).new

    line.each_char do |char|
      stack.push(char) if open_chars.includes?(char)

      if close_chars.includes?(char)
        i : Int32 = open_chars.index(stack.pop) || -1

        return corrupted.push(char) if char != close_chars[i]
      end
    end
  end

  def solve
    input.each do |line|
      parse_line(line)
    end

    sum = 0
    corrupted.each do |char|
      sum += 3 if char == ')'
      sum += 57 if char == ']'
      sum += 1197 if char == '}'
      sum += 25137 if char == '>'
    end

    p sum
  end
end

Pazzle.new.solve
