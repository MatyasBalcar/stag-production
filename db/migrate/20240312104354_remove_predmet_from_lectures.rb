class RemovePredmetFromLectures < ActiveRecord::Migration[7.1]
  def change
    remove_reference :lectures, :predmet, null: false, foreign_key: true
  end
end
