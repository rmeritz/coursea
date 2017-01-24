#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Multiplication
  def multiply a, b
    sum_subproducts(calculate_subproducts(to_digits(a), to_digits(b)))
  end

  private
  def to_digits n
    n.to_s.chars.map(&:to_i)
  end

  def sum_subproducts subproducts
    total_subproducts 0, subproducts, 1
  end

  def total_subproducts sum, subproducts, factor
    if subproducts.empty?
      sum
    else
      total_subproducts(sum + (subproducts.pop * factor), subproducts, factor * 10)
    end
  end

  def calculate_subproducts b, a
    a.map { |i| calculate_subproduct i, b.clone }
  end

  def calculate_subproduct i, b
    calc_subproduct(i, b, 0, [])
  end

  def calc_subproduct i, b, carry_over, subproduct
    if b.empty?
      subproduct.unshift(carry_over).join.to_i
    else
      carry_over, new_digit = carry_over_and_new_digit((i * b.pop) + carry_over)
      calc_subproduct(i, b, carry_over, subproduct.unshift(new_digit))
    end
  end

  def carry_over_and_new_digit product
    prod_mod = product % 10
    if prod_mod == product
      carry_over = 0
      new_digit = product
    else
      carry_over = product / 10
      new_digit = prod_mod
    end
    [carry_over, new_digit]
  end
end

class MultiplicationTest < Minitest::Test
  def setup
    @n = 13212312
    @b = 98090980
  end

  def test_multiplication
    assert_equal Multiplication.new.multiply(@n, @b), @n * @b
  end
end
