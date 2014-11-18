class CoursesController < ApplicationController
	def index
		@courses = Course.all
	end

	def new
		@course = Course.new
		@action = "Create course..."
	end

	def create
		@course = Course.create(course_params)
		if @course.save
			flash[:notice] = "Congratulations, your course has been created"
			redirect_to(courses_path) 
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Sorry, your course has not been created"
            render 'new'
		end			
	end

	def edit
		@course = Course.find(params[:id])
		@action = "Editar..."
	end

	def update
		@course = Course.find(params[:id])
		@course.update_attributes(course_params)

		if @course.update_attributes(course_params)
			redirect_to(courses_path)
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Sorry, your course has not been edited"
      render 'edit'
    end
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.destroy
			redirect_to(courses_path)
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Sorry, your course has not been deleted"
		end
	end

	private
	def course_params
		params.require(:course).permit(:name, :estimated_hours, :start_date, :end_date)
	end
end
