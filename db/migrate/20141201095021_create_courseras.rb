class CreateCourseras < ActiveRecord::Migration
  def change
    create_table :courseras do |t|
    	t.integer :course_id

      t.timestamps
    end
  end
end
