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

	#Format data to print all_courses chart
	def self.all_courses_chart(user)
		courses = []

		User.find(user).courses.each do |course|
			course_hash = {}
			course.tasks.each do |task|
				task.pomodoros.each do |pomodoro|
					if course_hash.has_key?(pomodoro.done_at)
						course_hash[pomodoro.done_at] += (pomodoro.minutes/60.0)
					else
						course_hash[pomodoro.done_at] = pomodoro.minutes/60.0
					end
				end
				puts course_hash
			end

			course_array = []
			course_hash.each do |course_date, course_hours|
				course_array.push([course_date.to_s.to_time.utc.to_i*1000, course_hours])
			end

			course_array = course_array.sort

			course_item = {name: course.name,
			data: course_array
			}
			courses.push(course_item)
		end

		return courses.to_json
	end

	#Format data to update minutes dedicated
	def self.update_minutes_dedicated(req)
		time_separated = JSON.parse(req)
		dedicated = time_separated[0]*60 + time_separated[1]
		pomodoro = time_separated[3]*60 + time_separated[4]
		if time_separated[5] == 'current'
			pomodoro_date = Date.current
		else
			pomodoro_date = time_separated[5].to_date
		end

		return [dedicated, time_separated[2], pomodoro, pomodoro_date]
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