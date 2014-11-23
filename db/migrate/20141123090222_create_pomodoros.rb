class CreatePomodoros < ActiveRecord::Migration
  def change
    create_table :pomodoros do |t|
    	t.integer :minutes
    	t.date :done_at
    	t.integer :task_id

      t.timestamps
    end
  end
end
