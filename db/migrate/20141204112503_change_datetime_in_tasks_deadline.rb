class ChangeDatetimeInTasksDeadline < ActiveRecord::Migration
  def change
  	remove_column :tasks, :deadline, :date 
  	add_column :tasks, :deadline, :datetime
  end
end
