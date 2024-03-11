class AddUserToPredmets < ActiveRecord::Migration[7.1]
  def change
    add_reference :predmets, :user, null: false, foreign_key: true
  end
end
