class AddReferencesToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :user, index: true
  end
end
  