class TimetableController < ApplicationController
  def index
    @timetable = Array.new(5) { Array.new(8) }
    @predmets = Predmet.includes(:lectures).all
    lectures = current_user.lectures
    lectures.each do |lecture|
      day_index = %w[monday tuesday wednesday thursday friday].index(lecture.day.downcase)
      time_slot_index = lecture.start_time.hour - 8
      @timetable[day_index][time_slot_index] = lecture
    end
    @lectures = lectures
  end
end