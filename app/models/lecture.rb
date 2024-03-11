class Lecture < ApplicationRecord
    belongs_to :predmet
    before_save :set_predmet_name

    validates :room, presence: true
    validates :day, presence: true
    validates :start_time, presence: true
    validates :teacher, presence: true
    

    require 'csv'

    def self.to_csv
      CSV.generate do |csv|
        column_names_without_id_and_predmet_id = column_names - ['id', 'predmet_id']
        csv << column_names_without_id_and_predmet_id
        all.each do |lecture|
          csv << lecture.attributes.values_at(*column_names_without_id_and_predmet_id)
        end
      end
    end
    def self.import(file, user)
      CSV.foreach(file.path, headers: true) do |row|
        lecture_hash = row.to_hash
        lecture_hash.delete("id") # remove id from hash
        predmet = user.predmets.find_by(name: lecture_hash["predmet_name"])
        if predmet
          predmet.lectures.create! lecture_hash.except("predmet_name")
        else
          # Handle the case where the predmet is not found
        end
      end
    end
    def set_predmet_name
      self.predmet_name = predmet.name 
    end

end
