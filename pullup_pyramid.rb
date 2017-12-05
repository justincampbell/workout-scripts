#!/usr/bin/env ruby -w

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

require_relative 'helpers'

sets = []
last_set = false

ready?

(1..Float::INFINITY).each do |reps|
  if last_set
    perform "as many pull-ups as you can"
    sets << ask("How many did you complete?").to_i
    puts sets.join(', ')
    exit
  end

  perform "pull-up", reps
  completed = ask("How many did you complete?", default: reps).to_i
  sets << completed

  last_set = true if completed != reps

  rest 10 * reps
end
