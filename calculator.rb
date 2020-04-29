OPERATIONS = { '1' => { operation: 'add',
                        method:    proc { |a, b| a + b },
                        verb:      'adding' },
               '2' => { operation: 'subtract',
                        method:    proc { |a, b| a - b },
                        verb:      'subtracting' },
               '3' => { operation: 'multiply',
                        method:    proc { |a, b| a * b },
                        verb:      'multiplying' },
               '4' => { operation: 'divide',
                        method:    proc { |a, b| a / b.to_f },
                        verb:      'dividing' } }.freeze

def prompt(message)
  puts ">> #{message}"
end

def valid_number?(num)
  Integer(num)
rescue
  nil
end

def valid_operation?(operation)
  OPERATIONS.keys.include? operation
end

prompt 'Welcome to the calculator!'
loop do
  number1 = ''
  prompt "What's the first number?"
  loop do
    number1 = gets.chomp

    break if valid_number?(number1)
    prompt('Please provide a valid number...')
  end
  number1 = number1.to_i

  number2 = ''
  prompt "What's the second number?"
  loop do
    number2 = gets.chomp

    break if valid_number?(number2)
    prompt('Please provide a valid number...')
  end
  number2 = number2.to_i

  prompt 'What operation would you like to perform?'
  OPERATIONS.each { |num, hash| puts "   #{num}) #{hash[:operation]}" }
  operation = ''
  loop do
    operation = gets.chomp
    break if valid_operation?(operation)
    prompt "Please select #{OPERATIONS.keys.join(', ')}"
  end

  result = OPERATIONS[operation][:method].call(number1, number2)

  prompt "#{OPERATIONS[operation][:verb].capitalize} #{number1} and #{number2}."
  prompt "The result is: #{result}"
  prompt 'Do you want to make another calculation? (Y to continue)'
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'
end
prompt 'Thanks for using the calculator, good bye!'
