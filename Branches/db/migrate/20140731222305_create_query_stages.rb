class CreateQueryStages < ActiveRecord::Migration
  def change
    create_table :query_stages do |t|
      t.belongs_to :queryTimes
      t.datetime :start
      t.datetime :end
      t.string :name

      t.timestamps
    end
  end
end
