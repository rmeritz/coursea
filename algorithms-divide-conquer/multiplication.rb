#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class Multiplication

  def brute_force_multiply a, b
    sum_subproducts(calculate_subproducts(to_digits(a), to_digits(b)))
  end

  def karatsuba_multiply a, b
    if (a < 10) || (b < 10)
      a * b
    else
      m = largest_number_length a, b
      m2 = (m/2.0).ceil
      i, j, k, l = new_numbers a, b, m2
      step_1 = karatsuba_multiply i, k
      step_2 = karatsuba_multiply j, l
      step_3 = karatsuba_multiply((i + j), (k + l)) #TODO: There is bug here!
      step_4 = step_3 - step_2 - step_1
      ((10 ** m) * step_1) + step_2 + ((10 ** m2) * step_4)
    end
  end

  private
  def new_numbers a, b, m
    a, b = to_digits(a), to_digits(b)
    [a.take(m), a.drop(m), b.take(m), b.drop(m)].map { |i| i.join.to_i }
  end

  def largest_number_length a, b
    [a, b].map { |i| number_of_digits(i) }.max
  end

  def number_of_digits a
    a.to_s.length
  end

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
    @multiplication = Multiplication.new
    @b = 1234
    @n = 5678
  end

  def test_brute_force_multiplication
    assert_equal @n * @b, @multiplication.brute_force_multiply(@n, @b)
  end

  def test_karatsuba_multiplication
    assert_equal @n * @b, @multiplication.karatsuba_multiply(@n, @b)
  end
end
