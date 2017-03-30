#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"
require "matrix"


class MatrixMultiplication

  def brute_force_matrix_multiply a, b
  end

  def strassen_subcubic_matrix_multiply a, b
  end

  private
end

class MatrixMultiplicationTest < Minitest::Test
  def setup
    @matrix_multiplication = MatrixMultiplication.new
    @m1 = Matrix[[1, 2], [3, 4]]
    @m2 = Matrix[[5, 6], [7, 8]]
  end

  def test_brute_force_matrix_multiplication
    assert_equal(@m1 * @m2,
                 @matrix_multiplication.brute_force_matrix_multiply(@m1, @m2)
                )
  end

  def test_strassen_subcubic_matrix_multiplication
    assert_equal(@m1 * @m2,
                 @matrix_multiplication.strassen_subcubic_matrix_multiply(@m1, @m2)
                )
  end
end
