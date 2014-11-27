class Course < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :tasks

	validates :name, presence: true
	#validate :start_date_is_today_or_after
	validate :end_date_is_after_start_date

	def start_date_is_today_or_after
		if start_date < (DateTime.current - 1)
			errors.add(:start_date, "can't be before today")
		end
	end

	def end_date_is_after_start_date
		if end_date <= start_date
			errors.add(:end_date, "can't be after or equal to start date")
		end
	end

	#Format data to print all_courses chart
	def self.all_courses_chart(user)
		courses = []

		User.find(user).courses.each do |course|
			course_hash = {}
			min_date = nil
			max_date = nil
			course.tasks.each do |task|
				task.pomodoros.each do |pomodoro|
					if course_hash.has_key?(pomodoro.done_at)
						course_hash[pomodoro.done_at] += (pomodoro.minutes/60.0)
					else
						course_hash[pomodoro.done_at] = pomodoro.minutes/60.0
					end
					

					if min_date==nil || min_date > pomodoro.done_at
						min_date = pomodoro.done_at
					end

					if max_date==nil || max_date < pomodoro.done_at
						max_date = pomodoro.done_at
					end

				end
			end
			puts min_date
			puts max_date
			if min_date != nil || max_date != nil
				(min_date..max_date).each do |date|
					if !course_hash.has_key?(date)
						course_hash[date] = 0
					end
				end
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

	def self.set_coursera_courses(courses)
		@@coursera_courses = courses 
	end

	def self.get_coursera_courses
		return @@coursera_courses
	end

	def self.get_data_from_session_array(session_array, session_id)
		start_day = nil
		end_day = nil
		puts session_array[0]
		session_array.each do |session|
			if session["id"] == session_id
				start_day = session["startYear"].to_s + "-" + session["startMonth"].to_s + "-" + session["startDay"].to_s
			end
		end
		puts session_id
		puts "AHI VA LA OSTIA!!!!!!!!!!!!!!!!!!!"
		puts start_day
		return start_day.to_s
	end

	def self.get_start_and_end_date(coursera_enrollments, course_id)
		start_date = nil
		end_date = nil
		coursera_enrollments.each do |course|
			if course["courseId"] == course_id
				start_date = course["startDate"]
				end_date = course["endDate"]
			end
		end
		return start_date, end_date
	end	

	
end
