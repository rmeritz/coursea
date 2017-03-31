#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class ClosestPair
  def brute_force_closest_pair l
    closest_pair(l.first, l.drop(1), nil)
  end

  def divide_and_conquer_closest_pair l
  end

  private

  def closest_pair point, points, pair
    if points.empty?
      pair
    else
      new_pair = find_closest_pair(point, points, pair)
      closest_pair(points.first, points.drop(1), new_pair)
    end
  end

  def find_closest_pair point, points, closest_pair
    points.each do |p|
      new_pair = Pair.new(point, p)
      if closest_pair.nil? || new_pair.distance < closest_pair.distance
        closest_pair = new_pair
      end
    end
    closest_pair
  end
end



class ClosestPairTest < Minitest::Test
  def setup
    @closest_pair = ClosestPair.new
    @p1 = Point.new(1, 1)
    @p2 = Point.new(1, 2)
    @p3 = Point.new(3, 3)
    @p4 = Point.new(7, 5)
    @p5 = Point.new(1, 1.5)
  end

  def test_brute_force_closest_pair
    assert_equal(Pair.new(@p1, @p2),
                 @closest_pair.brute_force_closest_pair([@p1, @p2, @p3, @p4])
                )
    assert_equal(Pair.new(@p1, @p5),
                 @closest_pair.brute_force_closest_pair([@p1, @p2, @p3, @p4, @p5])
                )
  end

  def test_divide_and_conqure_closest_pair
    skip
    assert_equal(Pair.new(@p1, @p2),
                 @closest_pair.divide_and_conquer_closest_pair([@p1, @p2, @p3, @p4])
                )
    assert_equal(Pair.new(@p1, @p5),
                 @closest_pair.divide_and_conquer_closest_pair([@p1, @p2, @p3, @p4, @p5])
                )
  end
end

class Point
  attr_reader :x, :y
  def initialize x, y
    @x = x
    @y = y
  end
end

class Pair
  attr_reader :distance, :p1, :p2
  def initialize p1, p2
    @p1 = p1
    @p2 = p2
    @distance = calculate_distance
  end

  def == other
    (@p1 == other.p1 && @p2 == other.p2) || (@p1 == other.p2 && @p2 == other.p1)
  end

  private

  def calculate_distance
    Math.sqrt((@p1.x - @p2.x)**2 + (@p1.y - @p2.y)**2)
  end
end
