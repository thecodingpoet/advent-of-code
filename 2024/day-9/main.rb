class DiskFragmenter
  attr_reader :blocks

  def initialize(disk_map='')
    @blocks = generate_block_representation(disk_map)
  end

  def compute_filesystem_checksum
    @blocks.each.with_index.sum {  |block, index| block.to_i * index }
  end

  private

  def generate_block_representation(disk_map)
    blocks = []

    disk_map.chars.each_slice(2).with_index do |(file_length, free_space_length), index|
      blocks.concat([index.to_s] * file_length.to_i)
      blocks.concat(('.' * free_space_length.to_i).chars)
    end
 
    shift_blocks_left(blocks)
  end

  def shift_blocks_left(blocks)
    write_pointer, read_pointer = 0, blocks.length - 1

    while write_pointer < read_pointer
      if blocks[write_pointer] == '.' && blocks[read_pointer] != '.'
        blocks[write_pointer], blocks[read_pointer] = blocks[read_pointer], blocks[write_pointer]
        write_pointer += 1
        read_pointer -= 1
      elsif blocks[write_pointer] != '.'
        write_pointer += 1
      elsif blocks[read_pointer] == '.'
        read_pointer -= 1
      end
    end

    blocks
  end
end

p DiskFragmenter.new('12345').compute_filesystem_checksum
p DiskFragmenter.new('2333133121414131402').compute_filesystem_checksum
p DiskFragmenter.new(File.read('input.txt')).compute_filesystem_checksum
