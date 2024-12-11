class PlutonianPebbles
  attr_reader :stones, :stones_frequency

  def initialize(stones)
    @stones = stones.split(' ').map(&:to_i)
    @stones_frequency = @stones.tally
  end

  def total_stones_after_blinks_part_1(num_of_blinks)
    num_of_blinks.times { blink }
    stones.count
  end

  def total_stones_after_blinks_part_2(num_of_blinks)
    num_of_blinks.times { optimized_blink }
    stones_frequency.values.sum
  end

  private

  def blink
    @stones = stones.map { |stone| compute_stone_results(stone) }.flatten
  end

  def optimized_blink
    new_stones_frequency = Hash.new(0)

    stones_frequency.each do |stone, count|
      result = compute_stone_results(stone)

      Array(result).each do |value|
        new_stones_frequency[value] += count
      end
    end

    @stones_frequency = new_stones_frequency
  end

  def compute_stone_results(stone)
    case  
    when stone == 0
      1
    when stone.to_s.length % 2 == 0
      [
        stone.to_s[0...stone.to_s.length / 2].to_i,
        stone.to_s[stone.to_s.length / 2...].to_i
      ]
    else
      stone * 2024
    end
  end
end

p PlutonianPebbles.new('5910927 0 1 47 261223 94788 545 7771').total_stones_after_blinks_part_1(25)
p PlutonianPebbles.new('5910927 0 1 47 261223 94788 545 7771').total_stones_after_blinks_part_2(75)
