class CreateQueryTimes < ActiveRecord::Migration
  def change
    create_table :query_times do |t|
      t.string :name

      t.timestamps
    end
  end
end
