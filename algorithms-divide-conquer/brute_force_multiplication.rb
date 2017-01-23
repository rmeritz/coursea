#!/usr/bin/env ruby

def to_digits n
  n.to_s.chars.map(&:to_i)
end

def total_subproducts sum, subproducts, factor
  if subproducts.empty?
    sum
  else
    total_subproducts(sum + (subproducts.pop * factor), subproducts, factor * 10)
  end
end

def sum_subproducts subproducts
  total_subproducts 0, subproducts, 1
end

def calc_subproduct i, b, carry_over, subproduct
  if b.empty?
    subproduct.unshift(carry_over).join.to_i
  else
    product = (i * b.pop) + carry_over
    prod_mod = product % 10
    if prod_mod == product
      carry_over = 0
      new_digit = product
    else
      carry_over = product / 10
      new_digit = prod_mod
    end
    calc_subproduct(i, b, carry_over, subproduct.unshift(new_digit))
  end
end

def calculate_subproduct i, b
  calc_subproduct(i, b, 0, [])
end

def calculate_subproducts b, a
  a.map { |i| calculate_subproduct i, b.clone }
end

def multiply a, b
  sum_subproducts(calculate_subproducts(to_digits(a), to_digits(b)))
end

b = 567812312
n = 123419999
puts multiply n, b
puts n * b
