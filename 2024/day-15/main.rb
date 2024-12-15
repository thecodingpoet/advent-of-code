class WarehouseWoes
  class << self
      GRID_ELEMENTS = [
        ROBOT = '@'.freeze,
        WALL = '#'.freeze,
        BOX = 'O'.freeze,
        EMPTY_SLOT = '.'.freeze
      ].freeze

      GRID_MOVEMENTS = {
        '^': [-1, 0],  
        'v': [1, 0],  
        '>': [0, 1],   
        '<': [0, -1]   
      }.freeze

      def sum_of_all_boxes_gps_coordinates(input)
        grid, movements = parse_input(input)

        robot_position = find_initial_robot_position(grid)
        movements.each_char { |direction| robot_position = move_robot(grid, robot_position, direction) }

        sum_boxes_coordinates(grid)
      end

      private

      def parse_input(input)
        warehouse_map, movements = input.split(/\n\n/)
        [
          warehouse_map.split("\n").map(&:chars),
          movements.delete("\n")
        ]
      end

      def find_initial_robot_position(grid)
        grid.each.with_index do |row, x|
          y = row.index(ROBOT)
          return [x, y] if y
        end
      end

      def move_robot(grid, initial_robot_position, direction)
        x1, y1 = initial_robot_position
        dx, dy = GRID_MOVEMENTS[direction.to_sym]

        x2 = x1 + dx
        y2 = y1 + dy

        case grid[x2][y2]
        when WALL
          return initial_robot_position
        when EMPTY_SLOT
          grid[x2][y2], grid[x1][y1] = grid[x1][y1], grid[x2][y2]
          return [x2, y2]
        when BOX
          next_empty_slot = find_next_empty_slot(grid, x2, y2, direction)
          return initial_robot_position unless next_empty_slot

          move_box(grid, next_empty_slot, direction)
        end
      end

      def find_next_empty_slot(grid, x, y, direction)
        dx, dy = GRID_MOVEMENTS[direction.to_sym]

        while grid[x][y] != EMPTY_SLOT
          return nil if grid[x][y] == WALL

          x = x + dx
          y = y + dy
        end

        return [x, y]
      end

      def move_box(grid, next_empty_slot, direction)
        x, y = next_empty_slot
        dx, dy = GRID_MOVEMENTS[direction.to_sym].map(&:-@)

        loop do
          grid[x][y], grid[x+dx][y+dy] = grid[x+dx][y+dy], grid[x][y]

          break if grid[x][y] == ROBOT

          x = x + dx
          y = y + dy
        end

        return [x, y]
      end

      def sum_boxes_coordinates(grid)
        sum = 0

        grid.each.with_index do |row, x|
          row.each.with_index do |col, y|
            next unless col == BOX
            sum += 100 * x + y
          end
        end

        sum
      end
  end
end

p WarehouseWoes.sum_of_all_boxes_gps_coordinates(File.read('input.txt'))
