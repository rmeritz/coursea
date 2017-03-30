#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"
require "matrix"


class MatrixMultiplication

  def brute_force_matrix_multiply a, b
    Matrix.rows(build_rows(a, b, 0, []))
  end

  def strassen_subcubic_matrix_multiply a, b
  end

  private

  def build_rows a, b, row_counter, product
    current_row = a.row(row_counter)
    if !current_row.nil?
      new_row = build_row(current_row, b, 0, [])
      build_rows(a, b, row_counter + 1, product << new_row)
    else
      product
    end
  end

  def build_row row_vector, b, column_counter, new_row
    current_column = b.column(column_counter)
    if !current_column.nil?
      new_element = dot_product(row_vector, current_column)
      build_row(row_vector, b, column_counter + 1, new_row << new_element)
    else
      new_row
    end
  end

  def dot_product row_vector, column_vector
    products = row_vector.map2(column_vector) {|r, v| r * v}
    products.reduce(0) {|s, e| s + e}
  end
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
    skip
    assert_equal(@m1 * @m2,
                 @matrix_multiplication.strassen_subcubic_matrix_multiply(@m1, @m2)
                )
  end
end
