require 'set'

class TopographicMap
  def self.sum_of_scores_of_all_trailheads_part_1(input)
    sum = 0

    grid = input.split(/\n/).map { |line| line.chars.map(&:to_i) }
    grid.each.with_index do |row, x|
      row.each.with_index do |col, y|
        next unless col == 0
        sum += recursive_move_count(grid, x, y)
      end
    end

    sum
  end

  def self.sum_of_scores_of_all_trailheads_part_2(input)
    sum = 0

    grid = input.split(/\n/).map { |line| line.chars.map(&:to_i) }
    grid.each.with_index do |row, x|
      row.each.with_index do |col, y|
        next unless col == 0
        sum += recursive_move_count(grid, x, y, true)
      end
    end
    
    sum
  end

  private

  def self.recursive_move_count(grid, x, y, allow_revisit = false, result = [])
    current_value = grid[x][y]
    next_value = current_value + 1

    if current_value == 9
      result << [x,y]
      return allow_revisit ? result.length : result.to_set.length
    end

    potential_moves = [
      [x, y - 1],
      [x, y + 1],
      [x + 1, y],
      [x - 1, y]
    ]

    potential_moves.each do |(move_x, move_y)|
      next unless within_grid?(grid, move_x, move_y)
      value = grid[move_x][move_y]
      next unless value == next_value

      recursive_move_count(grid, move_x, move_y, allow_revisit, result)
    end

    return allow_revisit ? result.length : result.to_set.length
  end

  def self.within_grid?(grid, x, y)
    x >= 0 && y >= 0 && x < grid[0].length && y < grid.length
  end
end

p TopographicMap.sum_of_scores_of_all_trailheads_part_1(File.read('input.txt'))
p TopographicMap.sum_of_scores_of_all_trailheads_part_2(File.read('input.txt'))
