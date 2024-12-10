class Day1
  def initialize(file_path='input.txt')
    @left_list, @right_list = build_list(file_path)
  end

  def total_distance
    sorted_left_list.zip(sorted_right_list).sum { |left, right| (right - left).abs }
  end

  def similarity_score
    right_list_tally = right_list.tally

    left_list.sum { |location_id| location_id * right_list_tally[location_id].to_i }
  end

  private  

  attr_reader :right_list, :left_list

  def build_list(file_path)
      left_list = []
      right_list = []

      File.foreach(file_path) do |line| 
          left_value, right_value = line.split.map(&:to_i)
          left_list << left_value
          right_list << right_value
      end

      [left_list, right_list]
  end

  def sorted_left_list
    @sorted_left_list ||= left_list.sort
  end

  def sorted_right_list
    @sorted_right_list ||= right_list.sort
  end
end

puts Day1.new.total_distance
puts Day1.new.similarity_score
