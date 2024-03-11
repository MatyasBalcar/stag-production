class CreateLectures < ActiveRecord::Migration[7.1]
  def change
    create_table :lectures do |t|
      t.string :room
      t.string :predmet_name
      t.string :teacher
      t.time :start_time
      t.time :end_time
      t.timestamps
    end
  end
end
