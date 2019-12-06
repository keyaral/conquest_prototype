class AddDefaultFalseForCompleteOnActivities < ActiveRecord::Migration[5.2]
  def up
    change_column :activities, :completed, :boolean, :default => false
  end
  
  def down
    change_column :activities, :completed, :boolean, :default => nil
  end
end
