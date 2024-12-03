class Day3
  attr_reader :input

  MUL_REGEX = /mul\((\d+),(\d+)\)/.freeze
  DO_COMMAND = 'do()'.freeze
  DONT_COMMAND = "don't()".freeze
  START_MUL_COMMAND = "mul(".freeze

  def initialize(file_path='input.txt')
    @input = read_input(file_path)
  end

  def sum_mul_commands
    input.scan(MUL_REGEX).sum { |left, right| left.to_i * right.to_i }
  end

  def sum_enabled_mul_commands
    enabled = true 

    left_pointer = right_pointer = 0

    matches = []

    while right_pointer < input.size 
      char = input[left_pointer]

      if enabled && input.slice(left_pointer, START_MUL_COMMAND.length) == START_MUL_COMMAND
        right_pointer = left_pointer + START_MUL_COMMAND.length
        char = input[right_pointer]

        while numeric_or_comma?(char)
          char = input[right_pointer]
          right_pointer += 1
        end

        matches << input.slice(left_pointer, right_pointer - left_pointer).scan(MUL_REGEX)
      elsif input.slice(left_pointer, DO_COMMAND.length) == DO_COMMAND
        enabled = true
        right_pointer += DO_COMMAND.length
      elsif input.slice(left_pointer, DONT_COMMAND.length) == DONT_COMMAND
        enabled = false
        right_pointer += DONT_COMMAND.length
      else
        right_pointer += 1
      end

      left_pointer = right_pointer
    end

    matches.flatten(1).sum { |left, right| left.to_i * right.to_i }
  end

  private

  def read_input(file_path)
    File.read(file_path)
  end

  def numeric_or_comma?(char)
    char.match?(/\d|,/)
  end
end

puts Day3.new.sum_mul_commands
puts Day3.new.sum_enabled_mul_commands
