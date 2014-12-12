class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:coursera]
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
	has_many :authentications
	has_and_belongs_to_many :courses

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    #user.image = auth.info.image # assuming the user model has an image
	  end
	end

	#Gets all tasks from a user
	def all_user_tasks
		user_tasks = []
		courses.each do |course|
			course.tasks.each do |task|
				user_tasks.push(task)
			end
		end
		return user_tasks
	end

	#Gets next deadline
	def get_next_deadline
		next_deadline = nil
		courses.each do |course|
			course.tasks.each do |task|
				if (next_deadline == nil || task.deadline.to_date < next_deadline) && task.deadline.to_date >= Time.current
					next_deadline = task.deadline
				end
			end
		end
		if next_deadline != nil
			next_deadline = next_deadline.to_date
		end
		return next_deadline
	end

	#Gets all deadlines with calendar format
	def all_deadlines
		deadlines = []
		courses.each do |course|
			
			course.tasks.each do |task|
				task_deadlines = {}
				task_deadlines["title"] = task.name + "-" + course.name
				task_deadlines["start"] = task.deadline
				task_deadlines["color"] = "red"
				deadlines.push(task_deadlines)
			end
			
			deadlines.push(calendar_course(course))
		end
		return deadlines
	end

	#gets course with calendar format
	def calendar_course(course)
		course_hash = {"title" => course.name + " (" + course.estimated_hours.to_s + "h/semana)", 
				"start" => course.start_date, 
				"end" => course.end_date}
		return course_hash
	end

	def get_all_courses_platform_percent
		platforms = {}
		courses.each do |course|
			if platforms.has_key?(course.platform)
				platforms[course.platform] += 1
			else
				platforms[course.platform] = 1
			end
		end
		return platforms
	end	

	#validates :name, presence: true
	#validates :name, length: { maximum: 25 }
end
