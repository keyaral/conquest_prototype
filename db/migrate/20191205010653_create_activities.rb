class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.integer :score_value
      t.boolean :completed

      t.timestamps
    end
  end
end
