#!/usr/bin/env ruby

class Fibonacci

  def initialize
    @fib_numbers = [0,1]
  end

  # Dynamic version of the Fibonacci generator (GOOD)
  def get(n)
    build(n) if (@fib_numbers.size-1 < n)
    @fib_numbers[n]
  end

  # Recursive version of the Fibonacci generator (BAD)
  def get_r(n)
    if n == 0 or n == 1 then
      n
    else
      get_r(n-2) + get_r(n-1)
    end
  end

  private

  def build(n)
    (@fib_numbers << @fib_numbers[-1] + @fib_numbers[-2]) until @fib_numbers.size > n
  end
  
end

fibo = Fibonacci.new

p fibo.get(1000) # much faster than below one even for big numbers!
p fibo.get_r(35) # very slow even for very small values...
