#!/usr/bin/env ruby

intcode = File.read('./input.txt').split(',').map(&:to_i)

require 'pry'

def run_intcode(intcode_input)
  intcode = intcode_input.dup
  pos = 0
  while true
    opcode = intcode[pos]

    # binding.pry
    case opcode
    when 99
      # puts "pos: #{pos}"
      break
    when 1
      part_1 = intcode[intcode[pos + 1]]
      part_2 = intcode[intcode[pos + 2]]
      intcode[intcode[pos + 3]] = part_1 + part_2
    when 2
      part_1 = intcode[intcode[pos + 1]]
      part_2 = intcode[intcode[pos + 2]]
      intcode[intcode[pos + 3]] = part_1 * part_2
    else
      raise "don't know opcode #{opcode}"
    end

    pos = pos + 4
  end

  intcode
end

def initialize_intcode(intcode, input)
  d = intcode.dup
  d[1] = input[0]
  d[2] = input[1]
  d
end

# puts run_intcode([1,0,0,0,99]).inspect
# puts run_intcode([2,3,0,3,99]).inspect
# puts run_intcode([2,4,4,5,99,0]).inspect
# puts run_intcode([1,1,1,4,99,5,6,0,99]).inspect

puts run_intcode(initialize_intcode(intcode, [12, 2])).first

(0..99).each do |x|
  (0..99).each do |y|
    target = 19690720
    output = run_intcode(initialize_intcode(intcode, [x, y])).first
    if output == 19690720
      puts "pair: #{[x, y].inspect}"
      puts 100 * x + y
      break
    end
  end
end
