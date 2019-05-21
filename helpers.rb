require 'optparse'

class Numeric
  def seconds
    self
  end

  def minutes
    self * 60
  end
  alias :minute :minutes
end

def alternating_side
  (@side ||= %w[left right].cycle).next
end

def ask(question, default: nil)
  print "#{question} "
  print "(#{default}) " if default

  result = STDIN.gets.chomp
  result = default if result.empty?

  puts
  result
end

def group_sets(sets)
  counts = sets.group_by(&:itself).transform_values(&:count)
  strings = counts.map { |completed_reps, completed_sets|
    if completed_sets == 1
      completed_reps
    else
      "#{completed_reps} x #{completed_sets}"
    end
  }
  strings.join(', ')
end

def perform(movement, reps = nil)
  print "Set #{set_counter.next}: "

  if reps
    pluralized = pluralize(reps, movement)
    say "#{reps} #{pluralized}"
    puts "Perform #{reps} #{pluralized}"
  else
    say "#{movement}"
    puts "Perform #{movement}"
  end
end

def pluralize(count, word)
  return word if count == 1

  "#{word}s"
end

def press_enter(suffix = "when done")
  puts "Press enter #{suffix}"
  STDIN.gets
end

def ready?(countdown: nil)
  press_enter "to begin"

  rest countdown, prefix: "Begin in" if countdown
end

def rest(seconds, prefix: "Rest for")
  if seconds % 60 == 0
    puts "#{prefix} #{seconds / 60} minutes"
  else
    puts "#{prefix} #{seconds} seconds"
  end

  (1..seconds).to_a.reverse.each do |remaining|
    unless remaining == seconds
      case remaining
      when 5.minutes then say "5 minutes"
      when 1.minute then say "1 minute"
      when 10.seconds, 30.seconds then say "#{remaining} seconds"
      end
    end

    sleep 1
  end

  puts
end

def say(phrase)
  Thread.new { `say -v Samantha #{phrase.inspect}` }
end

def set_counter
  @set_counter ||= (1..Float::INFINITY).enum_for
end
