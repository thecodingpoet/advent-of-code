class BridgeRepair
  attr_reader :calibration_equations

  OPERATORS = {
    addition: '+',
    multiplication: '*',
    concatenation: '||'
  }.freeze

  def initialize(file_name='input.txt')
    @calibration_equations = File.readlines(file_name)
  end

  def partial_calibration_total
    calibration_total(OPERATORS.values - [OPERATORS[:concatenation]])
  end

  def complete_calibration_total
    calibration_total(OPERATORS.values)
  end

  private

  def calibration_total(allowed_operators)
    @calibration_equations
      .filter { |equation| evaluate_equation(equation, allowed_operators) }
      .sum { |equation| equation.split(':').first.to_i }
  end

  def evaluate_equation(equation, allowed_operators)
    total, numbers = extract_values(equation)

    level = 0
    outcomes = [numbers.shift]

    while numbers.any?
      next_num = numbers.shift
      outcomes_at_current_level = outcomes.slice!(0, allowed_operators.count ** level)

      outcomes_at_current_level.each do |outcome|
        outcomes.concat(generate_outcomes(outcome, next_num, allowed_operators))
      end

      level += 1
    end

    outcomes.include?(total.to_i)
  end

  def generate_outcomes(outcome, next_num, allowed_operators)
    allowed_operators.map do |operator|
      case operator
      when OPERATORS[:addition]
        outcome + next_num
      when OPERATORS[:multiplication]
        outcome * next_num
      when OPERATORS[:concatenation]
        (outcome.to_s + next_num.to_s).to_i
      end
    end
  end

  def extract_values(equation)
    equation.split(':').then { |total, numbers| [total, numbers.split.map(&:to_i)] }
  end
end

puts BridgeRepair.new.partial_calibration_total
puts BridgeRepair.new.complete_calibration_total
