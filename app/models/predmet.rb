class Predmet < ApplicationRecord
    validates :name, presence: true
    validates :adbreviation, presence: true
    validates :status, presence: true
    validates :teacher, presence: true

    belongs_to :user

    has_many :lectures, dependent: :destroy

    require 'csv'

    def self.to_csv
        CSV.generate do |csv|
          column_names_without_user_id = column_names - ["user_id"]
          csv << column_names_without_user_id
          all.each do |predmet|
            csv << predmet.attributes.values_at(*column_names_without_user_id)
          end
        end
    end
    
    def self.import(file, user)
        CSV.foreach(file.path, headers: true) do |row|
          predmet_hash = row.to_hash
          predmet_hash.delete("id") # remove id from hash
          predmet_hash["user_id"] = user.id # set user_id to current user's id
          user.predmets.create! predmet_hash
        end
      end
end
