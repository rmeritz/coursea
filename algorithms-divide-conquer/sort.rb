#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Sort

  def brute_force_sort l
    naive_sort([], l)
  end

  def merge_sort l
    l
  end

  private
  def naive_sort(sorted, unsorted)
    if unsorted.empty?
      sorted
    else
      naive_sort(simple_insert(sorted, 0, unsorted.shift), unsorted)
    end
  end

  def simple_insert(sorted, sorted_pointer, to_insert)
    if sorted[sorted_pointer].nil?
      sorted + [to_insert]
    elsif to_insert < sorted[sorted_pointer]
      sorted.take(sorted_pointer) + [to_insert] + sorted.drop(sorted_pointer)
    else
      simple_insert sorted, sorted_pointer + 1, to_insert
    end
  end
end

class SortTest < Minitest::Test
  def setup
    @sort = Sort.new
    @sorted = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @already_sorted = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @backwards = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    @random = [6, 1, 10, 9, 5, 8, 7, 4, 2, 3]
  end

  def test_brute_force_sort
    assert_equal @sorted, @sort.brute_force_sort(@already_sorted)
    assert_equal @sorted, @sort.brute_force_sort(@backwards)
    assert_equal @sorted, @sort.brute_force_sort(@random)
  end

  def test_merge_sort
    skip
    assert_equal @sorted, @sort.merge_sort(@already_sorted)
    assert_equal @sorted, @sort.merge_sort(@backwards)
    assert_equal @sorted, @sort.merge_sort(@random)
  end
end
