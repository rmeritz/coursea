#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class ClosestPair
  def brute_force_closest_pair l
    closest_pair(l.first, l.drop(1), nil)
  end

  def divide_and_conquer_closest_pair l
    sorted_by_x = l.sort_by { |pair| pair.x }
    sorted_by_y = l.sort_by { |pair| pair.y }
    closest_pair_in_sorted_lists(sorted_by_x, sorted_by_y)
  end

  private

  def closest_pair_in_sorted_lists(sorted_by_x, sorted_by_y)
    if sorted_by_x.length <= 3
      brute_force_closest_pair(sorted_by_x)
    else
      left_half_sorted_by_x, right_half_sorted_by_x = half(sorted_by_x)
      left_half_sorted_by_y, right_half_sorted_by_y = half(sorted_by_y)
      closest_pair_in_left = closest_pair_in_sorted_lists(left_half_sorted_by_x, left_half_sorted_by_y)
      closest_pair_in_right = closest_pair_in_sorted_lists(right_half_sorted_by_x, right_half_sorted_by_y)
      delta = [closest_pair_in_left.distance, closest_pair_in_left.distance].min
      closest_split_pair = find_closest_split_pair(left_half_sorted_by_x.last.x, sorted_by_y, delta)
      [closest_pair_in_left, closest_pair_in_right, closest_split_pair].compact.min_by { |pair| pair.distance }
    end
  end

  def half l
    len = l.length
    [l.take(len/2), l.drop(len/2)]
  end

  def find_closest_split_pair x_bar, sorted_by_y, delta
    s_y = sorted_by_y.select { |p| (x_bar - delta) <= p.x && p.x <= (x_bar + delta) }
    find_closest_split_pair_in_s_y(s_y.first, s_y.drop(1), delta, nil)
  end

  def find_closest_split_pair_in_s_y(point, s_y, best_delta, closest_pair)
    if s_y.empty?
      closest_pair
    else
      new_best_delta, new_closest_pair= find_closest_pair_within_7_points(point, s_y.take(7), best_delta, closest_pair)
      find_closest_split_pair_in_s_y(s_y.first, s_y.drop(1), new_best_delta, new_closest_pair)
    end
  end

  def find_closest_pair_within_7_points(point, seven_points, delta, closest_pair)
    seven_points.each do |p|
      new_pair = Pair.new(point, p)
      if new_pair.distance < delta
        closest_pair = new_pair
        delta = new_pair.distance
      end
    end
    [delta, closest_pair]
  end


  ###################

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
    @p6 = Point.new(2, 3)
    @p7 = Point.new(12, 30)
    @p8 = Point.new(40, 50)
    @p9 = Point.new(5, 1)
    @p10 = Point.new(12, 10)
    @p11 = Point.new(3, 4)
  end

  def test_brute_force_closest_pair
    assert_equal(Pair.new(@p1, @p2),
                 @closest_pair.brute_force_closest_pair([@p1, @p2, @p3, @p4])
                )
    assert_equal(Pair.new(@p1, @p5),
                 @closest_pair.brute_force_closest_pair([@p1, @p2, @p3, @p4, @p5])
                )
    assert_equal(Pair.new(@p6, @p11),
                 @closest_pair.brute_force_closest_pair([@p6, @p7, @p8, @p9, @p10, @p11])
                )
  end

  def test_divide_and_conqure_closest_pair
    assert_equal(Pair.new(@p1, @p2),
                 @closest_pair.divide_and_conquer_closest_pair([@p1, @p2, @p3, @p4])
                )
    assert_equal(Pair.new(@p1, @p5),
                 @closest_pair.divide_and_conquer_closest_pair([@p1, @p2, @p3, @p4, @p5])
                )
    assert_equal(Pair.new(@p6, @p11),
                 @closest_pair.divide_and_conquer_closest_pair([@p6, @p7, @p8, @p9, @p10, @p11])
                )
  end
end

class Point
  attr_reader :x, :y
  def initialize x, y
    @x = x
    @y = y
  end

  def inspect
    "(#{x},#{y})"
  end
end

class Pair
  attr_reader :distance, :p1, :p2
  def initialize p1, p2
    @p1 = p1
    @p2 = p2
    @distance = calculate_distance
  end

  def inspect
    "#{p1.inspect}, #{p2.inspect}"
  end

  def == other
    (@p1 == other.p1 && @p2 == other.p2) || (@p1 == other.p2 && @p2 == other.p1)
  end

  private

  def calculate_distance
    Math.sqrt((@p1.x - @p2.x)**2 + (@p1.y - @p2.y)**2)
  end
end
