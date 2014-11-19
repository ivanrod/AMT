class Task < ActiveRecord::Base
	belongs_to :course

	validates :name, presence: true
	validates :task_type, presence: true
end