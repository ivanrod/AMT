class Task < ActiveRecord::Base
	belongs_to :course
	has_many :pomodoros

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

	#Format data to update minutes dedicated
	def self.update_minutes_dedicated(data)
		total_minutes = hours_to_minutes(data["hours"]) + data["minutes"]
		pomodoro = hours_to_minutes(data["pomodoro_hours"]) + data["pomodoro_minutes"]
		if data["pomodoro_date"] == 'current'
			pomodoro_date = Date.current
		else
			pomodoro_date = data["pomodoro_date"].to_date
		end
		
		newPomodoro = Task.find(data["task_id"]).pomodoros.new(minutes: pomodoro, done_at: pomodoro_date)

		Task.find(data["task_id"]).update_attributes(minutes_dedicated: total_minutes)
		
		if newPomodoro.save
			return "Bien"
		else
			return "mal"
		end
	end

	def self.hours_to_minutes(hours)
		minutes = hours*60
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