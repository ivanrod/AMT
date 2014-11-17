class Course < ActiveRecord::Base
	has_and_belongs_to_many :users

	validates :name, presence: true
	validates :start_date_is_today_or_after
	validates :end_date_is_after_start_date

	def start_date_is_today_or_after
		if start_date.to_i < DateTime.current
			errors.add(:start_date, "can't be before today")
		end
	end

	def end_date_is_after_start_date
		if end_date.to_i < start_date.to_i
			errors.add(:end_date, "can't be after start date")
		end
	end
end
