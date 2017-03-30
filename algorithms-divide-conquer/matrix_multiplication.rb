#!/usr/bin/env ruby

gem 'minitest'
require "minitest/autorun"
require "matrix"


class MatrixMultiplication

  def brute_force_matrix_multiply a, b
    Matrix.rows(build_rows(a, b, 0, []))
  end

  def naive_recursive_matrix_multiply x, y
    a, b, c, d = submatrixes(x)
    e, f, g, h = submatrixes(y)
    Matrix.vstack(
      Matrix.hstack(a*e + b*g,  a*f + b*h),
      Matrix.hstack(c*e + d*g, c*f + d*h)
    )
  end

  def strassen_subcubic_matrix_multiply x, y
    # a, b, c, d = submatrixes(x)
    # e, f, g, h = submatrixes(y)
    # p1 = a * (f-h)
    # p2 = (a + b) * h
    # p3 = (c + d) * e
    # p4 = d * (g - e)
    # p5 = (a + d) * (e + h)
    # p6 = (b - d) * (g + h)
    # p7 = (a - c) * (e + f)
    # [[(p5 + p4 - p2 + p6), (p1 + p2)], [(p3 + p4), (p1 + p5 - p3 - p7)]]
  end

  private

  def submatrixes a
    row_count = a.row_count
    column_count = a.column_count
    [
      a.minor(0, row_count/2, 0, column_count/2),
      a.minor(0, row_count/2, column_count/2, column_count/2),
      a.minor(row_count/2, row_count/2, 0, column_count/2),
      a.minor(row_count/2, row_count/2, column_count/2, column_count/2)
    ]
  end

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
    @m3 = Matrix[[1, 2, 3, 4],
                 [5, 6, 7, 8],
                 [9, 10, 11, 12],
                 [13, 14, 15, 16]
    ]
    @m4 = Matrix[[11, 12, 13, 14],
                 [15, 16, 17, 18],
                 [19, 110, 111, 112],
                 [113, 114, 115, 116]
    ]
  end

  def test_brute_force_matrix_multiplication
    assert_equal(@m1 * @m2,
                 @matrix_multiplication.brute_force_matrix_multiply(@m1, @m2)
                )
    assert_equal(@m3 * @m4,
                 @matrix_multiplication.brute_force_matrix_multiply(@m3, @m4)
                )
  end

  def test_naive_recursive_matrix_multiplication
    assert_equal(@m1 * @m2,
                 @matrix_multiplication.naive_recursive_matrix_multiply(@m1, @m2)
                )
    assert_equal(@m3 * @m4,
                 @matrix_multiplication.naive_recursive_matrix_multiply(@m3, @m4)
                )
  end

  def test_strassen_subcubic_matrix_multiplication
    skip
    assert_equal(@m1 * @m2,
                 @matrix_multiplication.strassen_subcubic_matrix_multiply(@m1, @m2)
                )
    assert_equal(@m3 * @m4,
                 @matrix_multiplication.strassen_subcubic_matrix_multiply(@m3, @m4)
                )
  end
end
