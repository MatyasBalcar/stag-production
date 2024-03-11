class RemoveTimesFromPredmeties < ActiveRecord::Migration[7.1]
  def change
    remove_column :predmeties, :start_time, :time
    remove_column :predmeties, :end_time, :time
  end
end
