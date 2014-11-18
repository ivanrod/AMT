class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.string :name
    	t.integer :estimated_hours
    	t.date :start_date
    	t.date :end_date
    	t.integer :user_id

      t.timestamps
    end
  end
end
