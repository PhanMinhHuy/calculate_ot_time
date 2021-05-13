require 'time'

def get_time time
  begin
    raise Exception unless time.match(/^\d{1,2}:\d{1,2}$/)
    Time.parse(time)
  rescue Exception
    puts "Please enter correct format: (hh:mm)"
    get_time gets.chomp
  end
end

def valid_time? time_in, time_out
  return time_out - time_in > 0 ? true : false
end

def calculate_ot_time time_in, time_out
  lunch = "N"
  dinner = "N"
  time_ot = (time_out - time_in)/3600

  if time_ot > 4 && time_in <= Time.parse("12:00") && time_out > Time.parse("13:00")
    lunch = "Y"
    time_ot -= 1
  end

  dinner = "Y" if time_ot > 3 && time_out > Time.parse("21:00")

  puts "OT: #{time_ot.round(2)}, Lunch: #{lunch}, Dinner: #{dinner}"
end

loop do
  puts "Enter check-in time: (hh:mm)"
  time_in = get_time gets.chomp

  puts "Enter check-out time: (hh:mm)"
  time_out = get_time gets.chomp

  if valid_time? time_in, time_out
    calculate_ot_time time_in, time_out
    break
  end

  puts "Please input time valid, in < out"
end
