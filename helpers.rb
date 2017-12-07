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

def ready?
  press_enter "to begin"
end

def rest(seconds)
  puts "Rest for #{seconds} seconds"

  (1..seconds).to_a.reverse.each do |remaining|
    unless remaining == seconds
      case remaining
      when 60 then say "1 minute"
      when 10, 30 then say "#{remaining} seconds"
      end
    end

    sleep 1
  end

  puts
end

def say(phrase)
  Thread.new { `say -v Samantha #{phrase.inspect}` }
end
