class Pomodoro < ActiveRecord::Base
	belongs_to :task

	validates :minutes, presence: true
end
