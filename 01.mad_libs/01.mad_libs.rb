#!/usr/bin/env ruby
# coding: utf-8

input_phrase = 'This is a ((thing name)). And it has a ((x:another thing)). We like ((x)).'

# Find question-tokens
pattern = /\(\((.+?)\)\)/
tokens = input_phrase.scan(pattern).flatten
text = input_phrase.split(pattern).flatten
answers = {}

# Ask questions
tokens.each do |token|
  begin
    subtoken = token.partition(':')[0]
    print "Define ((#{subtoken})): "
    answers[token] = answers[subtoken] = gets.chomp
  end if answers[token].nil?
end

# Show answer :-)
text.each do |word| print(answers[word] || word) end

puts

