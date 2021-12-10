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

        return Array(Char).new if char != close_chars[i]
      end
    end

    return stack
  end

  def get_score(stack)
    sum = 0.to_u64

    stack.reverse.each do |char|
      sum = sum * 5

      sum += 1 if char == '('
      sum += 2 if char == '['
      sum += 3 if char == '{'
      sum += 4 if char == '<'
    end

    return sum
  end

  def solve
    scores = Array(UInt64).new

    input.each do |line|
      score = get_score(parse_line(line))
      scores.push(score) if score > 0
    end

    scores.sort!

    p scores[(scores.size // 2)]
  end
end

Pazzle.new.solve
