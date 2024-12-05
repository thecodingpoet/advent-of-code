require 'set'

class PrintQueue
  attr_reader :page_prerequisites, :printing_updates

  def initialize(file_name='input.txt')
    @page_prerequisites = Hash.new { |hash, key| hash[key] = [] }
    @printing_updates = []

    load_file_data(file_name)
  end

  def middle_valid_page_number
    valid_updates.map { |update| middle_page(update) }.sum
  end

  private

  def valid_updates
    @valid_updates ||= printing_updates.filter { |update| valid_update?(update) }
  end

  def invalid_updates
    @invalid_updates ||= printing_updates - valid_updates
  end

  def valid_update?(update)
    update.each.with_index.all? do |page, index|
      (update[index..] & page_prerequisites[page]).empty?
    end
  end

  def middle_page(update)
    update[update.size / 2]
  end

  def load_file_data(file_name)
    File.readlines(file_name).map do |line|
      next if line.strip.empty?
     
      if line.match(/(\d+)\|(\d+)/)
        @page_prerequisites[$2.to_i] << $1.to_i
      else
        @printing_updates << line.split(',').map(&:to_i)
      end
    end
  end
end

p PrintQueue.new.page_prerequisites
p PrintQueue.new.printing_updates
# puts PrintQueue.new.valid?([75, 47, 61, 53, 29])
p PrintQueue.new.middle_valid_page_number
