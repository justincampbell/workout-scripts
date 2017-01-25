# Armstrong Pullup Program
# http://armstrongpullupprogram.com
#
# Day 2: Pyramid
#
# Start the pyramid with one repetition, the next set has two repetitions, the
# next has three. Continue in this fashion until you miss a set. (e.g. your
# last set was five, your next set would be six, but you could only do four.
# You missed a set) Do one more set at a maximum effort. Rest 10 seconds for
# each repetition in the previous set.

def say(phrase)
  Thread.new { `say #{phrase.inspect}` }
end

puts "Press enter to begin"
gets

(1..Float::INFINITY).each do |reps|
  say reps
  puts "Perform #{reps} #{reps == 1 ? "pull-up" : "pull-ups"}"
  puts "Press enter when done"
  gets

  seconds = reps * 10
  puts "Rest for #{seconds} seconds"
  sleep seconds

  puts
end
