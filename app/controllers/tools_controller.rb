class ToolsController < ApplicationController
	layout 'nav_amt'
	def index
	end

	def pomodoro
		@specific_css = ["flipclock.css"]
		@specific_js = ["tools/pomodoro.js","flipclock.min.js"]
	end
end
