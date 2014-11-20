class AddMinutesDedicatedToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :minutes_dedicated, :integer, default: 0

  end
end
