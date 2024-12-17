require 'set'

class GuardPatrolSimulator
  class << self
    GRID_MOVEMENTS = {
      '^': [-1, 0],  
      '>': [0, 1],   
      'v': [1, 0],  
      '<': [0, -1]   
    }.freeze

    DIRECTIONS = GRID_MOVEMENTS.keys.map(&:to_s).freeze

    def count_positions_visited_before_exit(grid)
      current_direction = DIRECTIONS[0]
      x, y = get_initial_guard_position(grid, current_direction)

      visited = Set.new([[x, y]])

      while x > 0 && x < grid.length - 1 && y > 0 && y < grid[0].length - 1
        dx, dy = GRID_MOVEMENTS[current_direction.to_sym]

        if grid[x + dx][y + dy] == '#'
          current_direction = turn_guard(current_direction)
        else
          x, y = x + dx, y + dy
          visited << [x, y]
        end
      end

      visited.size
    end

    private

    def turn_guard(current_direction)
      current_index = DIRECTIONS.index(current_direction)
      next_index = (current_index + 1) % DIRECTIONS.length
      DIRECTIONS[next_index]
    end

    def get_initial_guard_position(grid, current_direction)
      grid.each.with_index do |row, x|
        y = row.index(current_direction)
        return [x, y] if y
      end
    end
  end
end

grid = File.readlines('input.txt', chomp: true)
p GuardPatrolSimulator.count_positions_visited_before_exit(grid)