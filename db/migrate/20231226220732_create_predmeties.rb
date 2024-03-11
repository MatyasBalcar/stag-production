class CreatePredmeties < ActiveRecord::Migration[7.1]
  def change
    create_table :predmeties do |t|
      t.string :name
      t.string :abreviation
      t.time :start_time
      t.time :end_time
      t.string :teacher
      t.string :status
      t.timestamps
    end
  end
end
