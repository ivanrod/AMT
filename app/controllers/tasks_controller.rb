class TasksController < ApplicationController
	layout "nav_amt"
	def index
		@tasks = Course.find().tasks
	end

	def new
		@course = Course.find(params[:course_id])
		@task = @course.tasks.new
	end

	def create
		@course = Course.find(params[:course_id])
		@task = @course.tasks.new(task_params)
		
		if @task.save
			flash[:notice] = "Felicidades, tu tarea ha sido creada."
			redirect_to(my_courses_path) 
		else
			@errors	= @task.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido crear tu tarea"
        render 'new'
    end
	end

	def destroy
		@course = Course.find(params[:course_id])
		@task = Task.find(params[:id])
		if @task.destroy
			redirect_to(course_path(@course))
		else
			@errors = @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido borrar tu curso"
		end
	end

	def add_time
		if request.xhr?
			data_separated = JSON.parse(request.body.read)
			data_hash = {"hours" => data_separated[0].to_i,
									"minutes" => data_separated[1].to_i,
									"task_id" => data_separated[2],
								"pomodoro_hours" => data_separated[3],
								"pomodoro_minutes" => data_separated[4],
								"pomodoro_date" => data_separated[5]}

			@updated_and_new_pomodoro = Task.update_minutes_dedicated(data_hash)

			render json: @updated_and_new_pomodoro
			
		else
			render json: "Mal"
		end
	end

	def set_chart
		chart = Course.all_courses_chart(request.body.read)
		render json: chart
	end

	def task_params
		params.require(:task).permit(:name, :description, :deadline, :task_type)
	end
end
