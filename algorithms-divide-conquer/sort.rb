#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Sort

  def brute_force_sort l
    naive_sort([], l)
  end

  def merge_sort l
    len = l.length
    if len <= 1
      l
    else
      merge(merge_sort(l.take(len/2)), merge_sort(l.drop(len/2)))
    end
  end

  private

  def merge(a, b)
    do_merge(a, b, [])
  end

  def do_merge(a, b, merged_list)
    if a.first.nil?
      merged_list + b
    elsif b.first.nil?
      merged_list + a
    elsif a.first < b.first
      do_merge(a.drop(1), b, merged_list << a.first)
    elsif a.first >= b.first
      do_merge(a, b.drop(1), merged_list << b.first)
    end
  end

  ######################

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
    assert_equal @sorted, @sort.merge_sort(@already_sorted)
    assert_equal @sorted, @sort.merge_sort(@backwards)
    assert_equal @sorted, @sort.merge_sort(@random)
  end
end
