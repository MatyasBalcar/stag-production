require 'csv'
class DataImportsController < ApplicationController
  def import_inf_2
    user = current_user

    CSV.foreach(Rails.root.join('db/timetable_imports/inf_2sem_predmety.csv'), headers: true) do |row|
      predmet = user.predmets.create!(name: row[3], adbreviation: row[4], status: row[5], teacher: row[6], color: row[7])
    end
    
    CSV.foreach(Rails.root.join('db/timetable_imports/inf_2sem_hodiny.csv'), headers: true) do |row|
      predmet = Predmet.find_by(name: row[11])
      if predmet.nil?
        puts "Predmet not found with name: #{row[11]}"
      else
        color = predmet.color
        user.lectures.create!(room: row[0], teacher: row[1], start_time: Time.parse(row[2]), day: row[6], length: row[7], lecture_type: row[8], is_stacked: row[9], is_checked: row[10], predmet_name: row[11], color: color)
      end
    end
    redirect_to root_path, notice: 'Data imported successfully'
  end
end