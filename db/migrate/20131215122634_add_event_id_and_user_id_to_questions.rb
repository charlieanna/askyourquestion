class AddEventIdAndUserIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :event_id, :integer
    add_column :questions, :user_id, :integer
  end
end
