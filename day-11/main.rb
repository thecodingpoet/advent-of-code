class PlutonianPebbles
  attr_reader :stones

  def initialize(stones)
    @stones = stones.split(' ').map(&:to_i)
    @memo = {}
  end 

  def total_stones_after_blinks(num_of_blinks)
    num_of_blinks.times { blink }
    stones.count
  end

  private 

  def blink
    @stones = stones.map.with_index do |stone, index|
      @memo[stone] ||= compute_stone_results(stone)
    end.flatten(1)
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

p PlutonianPebbles.new('5910927 0 1 47 261223 94788 545 7771').total_stones_after_blinks(25)
