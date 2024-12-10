class WordSearch
  attr_reader :words

  DIRECTIONS = {
    horizontal: [:horizontal_right, :horizontal_left],
    vertical: [:vertical_up, :vertical_down],
    diagonal: [:diagonal_top_left, :diagonal_top_right, :diagonal_bottom_left, :diagonal_bottom_right]
  }.freeze

  def initialize(file_path = 'input.txt')
    @words = File.read(file_path).split(/\n/)
  end

  def sum_of_all_matches(target_word)
    sum = 0

    words.each.with_index do |word, row_index|
      word.each_char.with_index do |char, col_index|
        if char == target_word[0]
          sum += count_matches_in_all_directions(target_word, row_index, col_index)
        end
      end
    end

    sum
  end

  def sum_of_diagonal_cross_matches(target_word)
    sum = 0

    words.each.with_index do |word, row_index|
      next if row_index == 0 || row_index == words.length - 1

      word.each_char.with_index do |char, col_index|
        next unless char == target_word[target_word.length / 2]

        diagonals = extract_diagonal_words(row_index, col_index, target_word.length)
        sum += 1 if diagonals.count(target_word) == 2
      end
    end

    sum
  end

  private

  def count_matches_in_all_directions(target_word, row, col)
    DIRECTIONS.values.flatten.sum do |direction|
      word = extract_word_in_direction(row, col, target_word.length, direction)
      word == target_word ? 1 : 0
    end
  end

  def extract_diagonal_words(row, col, length)
    [
      extract_word_in_direction(row-1, col-1, length, :diagonal_bottom_right),
      extract_word_in_direction(row-1, col+1, length, :diagonal_bottom_left),
      extract_word_in_direction(row+1, col-1, length, :diagonal_top_right),
      extract_word_in_direction(row+1, col+1, length, :diagonal_top_left),
    ]
  end

  def extract_word_in_direction(starting_row, starting_column, size, direction)
    word = ''
    row, col = starting_row, starting_column

    case direction
    when :horizontal_right
      return words[row].slice(col, size)
    when :horizontal_left
      return words[row].slice(col - size + 1, size).reverse
    when :vertical_up
      row_step, col_step = -1, 0
    when :vertical_down
      row_step, col_step = 1, 0
    when :diagonal_top_left
      row_step, col_step = -1, -1
    when :diagonal_top_right
      row_step, col_step = -1, 1
    when :diagonal_bottom_left
      row_step, col_step = 1, -1
    when :diagonal_bottom_right
      row_step, col_step = 1, 1
    else
      raise "Invalid direction"
    end

    while row >= 0 && row < words.length && col >= 0 && col < words[row].length && word.length < size
      word += words[row][col]
      row += row_step
      col += col_step
    end

    word
  end
end

puts WordSearch.new.sum_of_all_matches('XMAS')
puts WordSearch.new.sum_of_diagonal_cross_matches('MAS')
