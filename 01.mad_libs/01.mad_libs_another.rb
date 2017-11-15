#!/usr/bin/env ruby
# coding: utf-8

input_phrase = 'This is a ((thing name)). And it has a ((x:another thing)). We like ((x)).'

# Ask question and show answer
answers = {}
puts(input_phrase.split(/(\(\(.+?\)\))/).map do |token|
  if token[0]=='(' and answers[token].nil? then 
    subtoken = token.partition(':')[0].delete('()')
    print "Define #{subtoken}: "
    answers['(('+subtoken+'))'] = gets.chomp
  end || answers[token] || token
end * '')





