require 'set'

class PrintQueue
  attr_reader :page_dependencies, :printing_updates

  def initialize(file_name='input.txt')
    @page_dependencies = Hash.new { |hash, key| hash[key] = [] }
    @printing_updates = []

    load_file_data(file_name)
  end

  def sum_of_middle_pages_in_valid_updates
    sum_of_middle_page_numbers(valid_updates)
  end

  def sum_of_middle_pages_in_invalid_updates
    corrected_updates = invalid_updates.map { |update| sort_invalid_update_by_dependencies(update) }
    sum_of_middle_page_numbers(corrected_updates)
  end

  private

  def valid_updates
    @valid_updates ||= printing_updates.filter { |update| valid_update?(update) }
  end

  def invalid_updates
    @invalid_updates ||= printing_updates - valid_updates
  end

  def sum_of_middle_page_numbers(updates)
    updates.map { |update| middle_page(update) }.sum
  end

  def valid_update?(update)
    update.each.with_index.all? do |page, index|
      (update[index..] & page_dependencies[page]).empty?
    end
  end

  def sort_invalid_update_by_dependencies(update)
    update.sort do |a, b|
      if page_dependencies[b].include?(a)
        -1 
      elsif page_dependencies[a].include?(b)
        1 
      else
        0 
      end
    end
  end

  def middle_page(update)
    update[update.size / 2]
  end

  def load_file_data(file_name)
    File.readlines(file_name).each do |line|
      next if line.strip.empty?
     
      if line.match(/(\d+)\|(\d+)/)
        page_dependencies[$2.to_i] << $1.to_i
      else
        printing_updates << line.split(',').map(&:to_i)
      end
    end
  end
end

puts PrintQueue.new.sum_of_middle_pages_in_valid_updates
puts PrintQueue.new.sum_of_middle_pages_in_invalid_updates
