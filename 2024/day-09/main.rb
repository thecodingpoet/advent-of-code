require 'set'

class DiskFragmenter
  def self.compute_filesystem_checksum_part_1(disk_map)
    blocks = generate_block_representation(disk_map)

    left_pointer, right_pointer = 0, blocks.length - 1

    while left_pointer < right_pointer
      if blocks[left_pointer] == '.' && blocks[right_pointer] != '.'
        blocks[left_pointer], blocks[right_pointer] = blocks[right_pointer], blocks[left_pointer]
        left_pointer += 1
        right_pointer -= 1
      elsif blocks[left_pointer] != '.'
        left_pointer += 1
      elsif blocks[right_pointer] == '.'
        right_pointer -= 1
      end
    end

    calculate_checksum(blocks)
  end

  def self.compute_filesystem_checksum_part_2(disk_map)
    blocks = generate_block_representation(disk_map)
    file_id_tally = blocks.tally

    blocks.uniq.reverse_each do |file_id|
      file_id_count = file_id_tally[file_id]
      right_pointer = blocks.index(file_id)
      free_space_block = ['.'] * file_id_count

      (0...right_pointer).each do |left_pointer| 
        if blocks[left_pointer, file_id_count] == free_space_block
          temp = blocks[right_pointer, file_id_count] 
          blocks[right_pointer, file_id_count] = blocks[left_pointer, file_id_count]
          blocks[left_pointer, file_id_count] = temp
          break
        end
      end
    end

    calculate_checksum(blocks)
  end

  private 

  def self.generate_block_representation(disk_map)
    blocks = []

    disk_map.chars.each_slice(2).with_index do |(file_length, free_space_length), index|
      blocks.concat([index.to_s] * file_length.to_i)
      blocks.concat(('.' * free_space_length.to_i).chars)
    end

    blocks
  end

  def self.calculate_checksum(disk_blocks)
    disk_blocks.each.with_index.sum { |block, index| block.to_i * index }
  end
end

p DiskFragmenter.compute_filesystem_checksum_part_1('2333133121414131402')
p DiskFragmenter.compute_filesystem_checksum_part_2('2333133121414131402')
