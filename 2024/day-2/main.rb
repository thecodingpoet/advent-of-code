class Day2
  attr_reader :report

  MIN_LEVEL_DIFFERENCE = 1
  MAX_LEVEL_DIFFERENCE = 3
  LEVEL_DIFFERENCE_RANGE = (MIN_LEVEL_DIFFERENCE..MAX_LEVEL_DIFFERENCE)

  def initialize(file_path='input.txt')
    @report = build_levels(file_path)
  end

  def number_of_safe
    report.count { |levels| safe?(levels) }
  end

  private

  def build_levels(file_path)
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
      LEVEL_DIFFERENCE_RANGE.include?(difference)
    end
  end
end

p Day2.new.number_of_safe