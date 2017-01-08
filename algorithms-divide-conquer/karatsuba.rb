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

def karatsuba n, m
  n.to_i * m.to_i
end

y = "5678"
x = "1234"

puts karatsuba(x, y)
