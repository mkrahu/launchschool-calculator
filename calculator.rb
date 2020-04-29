# frozen_string_literal: true

puts 'Welcome to the calculator!'

puts "What's the first number?"
number1 = gets.chomp.to_i

puts "What's the second number?"
number2 = gets.chomp.to_i

puts 'What operation would you like to perform?'
puts '1) add 2) subtract 3) multiply 4) divide'
operation = gets.chomp

result = case operation
         when '1' then number1 + number2
         when '2' then number1 - number2
         when '3' then number1 * number2
         when '4' then number1 / number2.to_f
         end

puts "The result is: #{result}"
