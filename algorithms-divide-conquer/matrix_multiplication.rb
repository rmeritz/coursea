#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"


class MatirxMultiplication

  def brute_force_matrix_multiply a, b
  end

  def strassen_subcubic_matrix_multiply a, b
  end

  private
end

class MatirxMultiplicationTest < Minitest::Test
  def setup
    @matrix_multiplication = MatirxMultiplication.new
  end

  def test_brute_force_matrix_multiplication
  end

  def test_strassen_subcubic_matrix_multiplication
  end
end
