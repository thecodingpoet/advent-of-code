require 'set'

class Day2
  attr_reader :report

  VALID_LEVEL_RANGE = (1..3).freeze

  def initialize(file_path='input.txt')
    @report = build_report(file_path)
  end

  def number_of_safe_level(tolerate_single_bad_level: false)
    report.count do |levels|
      if tolerate_single_bad_level
        levels.combination(levels.size - 1).any? { |subset| safe?(subset) }
      else
        safe?(levels)
      end
    end
  end

  private

  def build_report(file_path)
    unless File.exist?(file_path)
      raise ArgumentError, "File not found: #{file_path}"
    end

    File.readlines(file_path).map { |line| line.split.map(&:to_i) }
  end

  def safe?(levels)
    strictly_increasing?(levels) || strictly_decreasing?(levels)
  end

  def strictly_increasing?(levels)
    strictly_monotonic?(levels, :increasing)
  end

  def strictly_decreasing?(levels)
    strictly_monotonic?(levels, :decreasing)
  end
  
  def strictly_monotonic?(levels, direction)
    levels.each_cons(2).all? do |prev_level, current_level|
      difference = direction == :increasing ? current_level - prev_level : prev_level - current_level
      VALID_LEVEL_RANGE.include?(difference)
    end
  end
end

p Day2.new.number_of_safe_level
p Day2.new.number_of_safe_level(tolerate_single_bad_level: true)