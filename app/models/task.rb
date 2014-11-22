class Task < ActiveRecord::Base
	belongs_to :course

	validates :name, presence: true
	validates :task_type, presence: true
	validate :deadline_is_in_course_time

	def deadline_is_in_course_time
		if (deadline < Course.find(course_id).start_date && deadline > Course.find(course_id).end_date) 
			errors.add(:start_date, "can't be out of course")
		end
	end

	#Separate time in minutes and hours
	def separateTime
		hours = minutes_dedicated / 60
		minutes = minutes_dedicated % 60
		return [hours, minutes]
	end

	#Update minutes dedicated
	def self.update_minutes_dedicated(req)
		time_separated = JSON.parse(req)
		dedicated = time_separated[0]*60 + time_separated[1]
		return [dedicated, time_separated[2]]
	end

	#First deadline
	def self.first_deadline
		first = Date.current+1000
		all.each do |task|
			if first > task.deadline
				first = task.deadline
			end
		end
		return first
	end
end