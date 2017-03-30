#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Inversions
  def brute_force_inversions l
    do_brute_force_inversions l.drop(1), l.first, 0
  end

  def merge_sort_to_count_inversions l
    merge_sort_inversions(l, 0)[1]
  end

  private

  def merge_sort_inversions l, count
    len = l.length
    if len <= 1
      [l, count]
    else
      left = merge_sort_inversions(l.take(len/2), 0)
      right = merge_sort_inversions(l.drop(len/2), 0)
      merge(left.first, right.first, count + left[1] + right[1])
    end
  end

  def merge(a, b, count)
    do_merge(a, b, [], count)
  end

  def do_merge(a, b, merged_list, count)
    if a.first.nil?
      [merged_list + b, count]
    elsif b.first.nil?
      [merged_list + a, count]
    elsif a.first < b.first
      do_merge(a.drop(1), b, merged_list << a.first, count)
    elsif a.first >= b.first
      do_merge(a, b.drop(1), merged_list << b.first, count + a.length)
    end
  end

  ############

  def do_brute_force_inversions l, first, count
    if l.empty?
      count
    else
      do_brute_force_inversions(l.drop(1), l.first, get_inversion_for_pair(l, first, count))
    end
  end

  def get_inversion_for_pair l, first, count
    l.inject(count) do | c, n |
      if first > n
        c + 1
      else
        c
      end
    end
  end
end



class InversionsTest < Minitest::Test
  def setup
    @inversions = Inversions.new
    @none = [1, 2, 3, 4, 5, 6]
    @max = [6, 5, 4, 3, 2, 1]
    @some = [1, 3, 5, 2, 4, 6]
    @right = [2, 1, 3, 4, 5, 6]
    @left = [1, 2, 3, 4, 6, 5]
  end

  def test_brute_force_inversions
    assert_equal(0, @inversions.brute_force_inversions(@none))
    assert_equal(15, @inversions.brute_force_inversions(@max))
    assert_equal(3, @inversions.brute_force_inversions(@some))
    assert_equal(1, @inversions.brute_force_inversions(@right))
    assert_equal(1, @inversions.brute_force_inversions(@left))
  end

  def test_merge_sort_to_count_inversions
    assert_equal(0, @inversions.merge_sort_to_count_inversions(@none))
    assert_equal(15, @inversions.merge_sort_to_count_inversions(@max))
    assert_equal(3, @inversions.merge_sort_to_count_inversions(@some))
    assert_equal(1, @inversions.merge_sort_to_count_inversions(@right))
    assert_equal(1, @inversions.merge_sort_to_count_inversions(@left))
  end
end
