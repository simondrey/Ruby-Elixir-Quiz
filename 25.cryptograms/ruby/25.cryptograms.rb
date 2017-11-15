#!/usr/bin/env ruby

class Decryptor
  def initialize

  end

  def decrypt(string)
    string
  end

  def shift(string, positions)
    string.bytes.map do |byte|
      (byte + positions).chr
    end.join
  end
end

test0 = "abcd efgh ijkl mnop"
test1 = "gebo tev e cwaack cegn"
test2 = "mary had a little lamb"

d = Decryptor.new

puts d.shift(d.shift(test0,13),-13)
