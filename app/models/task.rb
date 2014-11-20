class Task < ActiveRecord::Base
	belongs_to :course

	validates :name, presence: true
	validates :task_type, presence: true
	validate :deadline_is_in_course_time

	def deadline_is_in_course_time
		puts deadline < Course.find(course_id).start_date
		if (deadline < Course.find(course_id).start_date && deadline > Course.find(course_id).end_date) 
			errors.add(:start_date, "can't be out of course")
		end
	end
end