class AddPredmetToLectures < ActiveRecord::Migration[7.1]
  def change
    add_reference :lectures, :predmet, null: false, foreign_key: true
  end
end
