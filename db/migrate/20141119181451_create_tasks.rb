class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.string :name
    	t.text :description
    	t.string :task_type
    	t.date :deadline
    	t.integer :course_id

      t.timestamps
    end
  end
end
