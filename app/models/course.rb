class Course < ActiveRecord::Base
	has_and_belongs_to_many :users

	validates :name, presence: true
	validate :start_date_is_today_or_after
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
end
