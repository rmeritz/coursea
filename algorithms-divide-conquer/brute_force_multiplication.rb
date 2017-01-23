#!/usr/bin/env ruby

def to_digits n
  n.to_s.chars.map(&:to_i)
end

def total_subproducts sum, subproducts, factor
  if subproducts.empty?
    sum
  else
    total_subproducts(sum + (subproducts.shift * factor), subproducts, factor * 10)
  end
end

def sum_subproducts subproducts
  total_subproducts 0, subproducts, 1
end

def calculate_subproduct i, b
  i * b.join.to_i
end

def calculate_subproducts a, b
  a.map { |i| calculate_subproduct i, b }
end

def multiply a, b
  sum_subproducts(calculate_subproducts(to_digits(a), to_digits(b)))
end

b = 12312315
n = 9
puts multiply n, b
puts n * b
