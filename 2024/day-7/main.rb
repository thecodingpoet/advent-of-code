class BridgeRepair
  attr_reader :calibration_equations

  OPERATORS = {
    addition: '+',
    multiplication: '*'
  }.freeze

  def initialize(file_name='input.txt')
    @calibration_equations = File.readlines(file_name)
  end

  def total_calibration_result
    @calibration_equations
      .filter { |equation| valid_equation?(equation) }
      .sum { |equation| equation.split(':').first.to_i }
  end

  private

  def valid_equation?(equation)
    total, numbers = extract_values(equation)

    outcomes = [numbers.shift]
    level = 0

    while numbers.length > 0
      next_num = numbers.shift 
      
      outcomes_at_current_level = outcomes.slice!(0, 2 ** level)

      outcomes_at_current_level.each.with_index do |outcome, index|
        OPERATORS.values.each do |operator|
          outcomes << eval("#{outcome.to_s}#{operator}#{next_num}")
        end
      end

      level += 1
    end

    outcomes.include?(total.to_i)
  end

  def extract_values(equation)
    equation.split(':').then { |total, numbers| [total, numbers.split] }
  end
end

puts BridgeRepair.new.total_calibration_result