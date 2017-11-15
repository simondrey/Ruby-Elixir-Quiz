#!/usr/bin/env ruby
# coding: utf-8

# Digits from 0 to 9 in binary vectors encoded in decimal numbers
digits = [175,9,158,155,57,179,183,137,191,187]

# Decode a digit from code to the array of strings
def digit_to_lcd(code,size,spc = ' ', vs = '|', hs = '-')
  str = (code+256).to_s(2); str[0] = '0'
  str.gsub!('0',spc).gsub!('1',hs)
  
  [   spc + str[1]*size + spc,
  (str[3] +    spc*size + str[5]).gsub(hs,vs),
      spc + str[4]*size + spc,
  (str[6] +    spc*size + str[8]).gsub(hs,vs),
      spc + str[7]*size + spc
  ].map do |row|
    row.include?(vs) ? Array.new(size,row) : row
  end.flatten
end

# Parsing command line arguments & preparing the list of digits to show
size = 2 # Default size of output characters
digits_to_show = (
  if ARGV.size == 3 then size = ARGV[1].to_i; ARGV[2]
  elsif ARGV.size == 1 then ARGV[0]
  else '0123456789' end
).each_char.map do |e| e.to_i end

# 'Rendering' the output
output = Array.new(3+size*2,"")
digits_to_show.each do |digit|
  digit_to_lcd(digits[digit],size).each_with_index do |row,j|
    output[j] = output[j] + row + " "
  end
end

# Mesdames et Messieurs, voilà!
output.each do |row| puts row end
