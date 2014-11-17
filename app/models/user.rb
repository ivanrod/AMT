class User < ActiveRecord::Base
	has_and_belongs_to_many :courses

	validates :name, presence: true
	validates :name, length: { maximum: 25 }
end
