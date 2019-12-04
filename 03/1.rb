#!/usr/bin/env ruby

require 'pry'

def parse_input(input)
  input.lines.map { |ln| ln.strip.split ',' }
end

def run_paths(paths)
  Enumerator.new do |y|
    pos = [0, 0]
    paths.each do |path|
      dir = path[0]
      len = path[1..-1].to_i

      case dir.upcase
      when 'U'
        len.times do |i|
          pos[1] += 1
          y.yield pos.dup
        end
      when 'D'
        len.times do |i|
          pos[1] -= 1
          y.yield pos.dup
        end
      when 'L'
        len.times do |i|
          pos[0] -= 1
          y.yield pos.dup
        end
      when 'R'
        len.times do |i|
          pos[0] += 1
          y.yield pos.dup
        end
      else
        raise "don't know dir #{dir}"
      end
    end
  end
end

def intersection_point(wires)
  wires.map { |paths| run_paths(paths).to_a }
    .inject(&:&)
    .min_by { |coord| coord.map(&:abs).sum }
    .then do |coord|
      coord&.map(&:abs)&.sum
    end
end

wires = File.read('./input.txt')

# d = 'R75,D30,R83,U83,L12,D49,R71,U7,L72
# U62,R66,U55,R34,D71,R55,D58,R83'

# d = 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
# U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'

d = wires
puts intersection_point(parse_input d).inspect
