require 'yaml'

MESSAGES = YAML.load_file("config.yml")

OPERATIONS = { '1' => { operation: MESSAGES['op1']['operation'],
                        method:    proc { |a, b| a + b },
                        verb:      MESSAGES['op1']['verb'] },
               '2' => { operation: MESSAGES['op2']['operation'],
                        method:    proc { |a, b| a - b },
                        verb:      MESSAGES['op2']['verb'] },
               '3' => { operation: MESSAGES['op3']['operation'],
                        method:    proc { |a, b| a * b },
                        verb:      MESSAGES['op3']['verb'] },
               '4' => { operation: MESSAGES['op4']['operation'],
                        method:    proc { |a, b| a / b.to_f },
                        verb:      MESSAGES['op4']['verb'] },
               '5' => { operation: MESSAGES['op5']['operation'],
                       method:    proc { |a, b| a % b.to_f },
                       verb:      MESSAGES['op5']['verb'] } }.freeze

def prompt(message)
  puts ">> #{message}"
end

def valid_number?(num)
  Integer(num)
rescue ArgumentError
  nil
end

def numeric?(num)
  !Float(num).nil?
rescue ArgumentError
  false
end

def float?(num)
  num == num.to_f.to_s
end

def integer?(num)
  num == num.to_i.to_s
end

def valid_operation?(operation)
  OPERATIONS.keys.include? operation
end

prompt(MESSAGES['welcome'])
loop do
  number1 = ''
  prompt(MESSAGES['number1_prompt'])
  loop do
    number1 = gets.chomp

    break if numeric?(number1)
    prompt(MESSAGES['number_error'])
  end

  number1 = number1.to_f if float?(number1)
  number1 = number1.to_i if integer?(number1)

  number2 = ''
  prompt(MESSAGES['number2_prompt'])
  loop do
    number2 = gets.chomp

    break if numeric?(number2)
    prompt(MESSAGES['number_error'])
  end
  number2 = number2.to_f if float?(number2)
  number2 = number2.to_i if integer?(number2)

  prompt(MESSAGES['operations'])
  OPERATIONS.each { |num, hash| puts "   #{num}) #{hash[:operation]}" }
  operation = ''
  loop do
    operation = gets.chomp
    break if valid_operation?(operation)
    prompt "#{MESSAGES[operations_error]} #{OPERATIONS.keys.join(', ')}"
  end

  result = OPERATIONS[operation][:method].call(number1, number2)

  prompt "#{OPERATIONS[operation][:verb].capitalize} #{number1} " \
         "#{MESSAGES['and']} #{number2}."
  prompt "#{MESSAGES['result']} #{result}"
  prompt(MESSAGES['another_calc'])
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'
end

prompt(MESSAGES['goodbye'])
