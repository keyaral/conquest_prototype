class AddUserAssignmentToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :assignee_id, :integer
  end
end
