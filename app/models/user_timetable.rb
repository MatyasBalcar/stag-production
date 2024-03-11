class UserTimetable < ApplicationRecord
  belongs_to :user
  has_one_attached :data_file

  require 'zip'

  def self.import(file, user)
    tempfile = Tempfile.new
    tempfile.binmode
    tempfile.write(file.download)
    tempfile.rewind
  
    Zip::File.open(tempfile.path) do |zip_file|
      entries = zip_file.entries
  
      # First, handle all 'predmets'
      entries.each do |entry|
        next unless entry.file? && entry.name.include?('predmets')
  
        CSV.parse(entry.get_input_stream.read, headers: true) do |row|
          predmet_hash = row.to_hash
          predmet_hash.delete("id") # remove id from hash
          predmet_hash["user_id"] = user.id # set user_id to current user's id
          user.predmets.create! predmet_hash
        end
      end
  
      # Then, handle all 'lectures'
      entries.each do |entry|
        next unless entry.file? && entry.name.include?('lectures')
  
        CSV.parse(entry.get_input_stream.read, headers: true) do |row|
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
    end
  
    tempfile.close
    tempfile.unlink
  end
  validate :correct_document_mime_type

  private

  def correct_document_mime_type
    if data_file.attached? && !data_file.content_type.in?('application/zip')
      errors.add(:data_file, 'Must be a ZIP file')
    end
  end
end