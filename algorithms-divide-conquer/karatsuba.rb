#!/usr/bin/env ruby

#In this programming assignment you will implement one or more of the integer multiplication algorithms described in lecture.
#
#To get the most out of this assignment, your program should restrict itself to multiplying only pairs of single-digit numbers. You can implement the grade-school algorithm if you want, but to get the most out of the assignment you'll want to implement recursive integer multiplication and/or Karatsuba's algorithm.
#
#So: what's the product of the following two 64-digit numbers?
#
#3141592653589793238462643383279502884197169399375105820974944592
#
#2718281828459045235360287471352662497757247093699959574966967627
#
#[TIP: before submitting, first test the correctness of your program on some small test cases of your own devising. Then post your best test cases to the discussion forums to help your fellow students!]

def normalize_length q
  if q.length.odd?
    "0" + q
  else
    q
  end
end

def karatsuba n, m
  puts "n = #{n}; m = #{m}"
  n = normalize_length n
  m = normalize_length m
  len_n = n.length
  len_m = m.length

  if len_n == 2 || len_m == 2
    n.to_i * m.to_i
  else
    a = n[0..(len_n/2 - 1)]
    b = n[(len_n/2)..len_n]
    c = m[0..(len_m/2 - 1)]
    d = m[(len_m/2)..len_m]

    step_1 = karatsuba a, c
    step_2 = karatsuba b, d
    step_3 = karatsuba((a.to_i + b.to_i).to_s, (c.to_i + d.to_i).to_s)
    step_4 = step_3 - step_2 - step_1
    ((10 ** len_n) * step_1) + step_2 + ((10 ** (len_n/2)) * step_4)
  end
end

y = "5678"
x = "1234"

puts karatsuba(y, x)

#TODO:
# - Does the algorithim work if n and m are not the same lenght?
# - What happens in len is odd?
# - When is a more approiate time to normalize the length?
