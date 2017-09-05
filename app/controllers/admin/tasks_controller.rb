class Admin::TasksController < Admin::BaseController
	include Admin::TaskHelper
	  before_action :find_task, only: [:edit, :update]

	def index
		@create_assign_user = true
		@tasks = Task.includes(:user).all
	end

	def edit
		@all_status =  {1 => "New", 2 => "In Progress", 3 => "Completed", 4 => "Expired", 5 => "Pending Approved", 6 => "Completed and Approved "}.map{|k,v| [v,k] }
	end

	def update
		respond_to do |format|
		  if @task.update(task_params)
		    format.html { redirect_to admin_tasks_path, notice: 'Task was successfully updated.' }
		    format.json { render :show, status: :ok, location: @task }
		  else
		    format.html { render :edit }
		    format.json { render json: @task.errors, status: :unprocessable_entity }
		  end
		end
	end

	def assign_users
		tasks = Task.where(:id=> params["task"]["task_id"].split(',').uniq)
		tasks.update_all("user_id = #{params['task']['user_id']}")
		redirect_to admin_tasks_path, notice: 'Task was successfully updated.'
	end

	def task_params
		params.require(:task).permit(:name, :status, :user_id)
	end

	def pending_approval
		@tasks = Task.where(:status => 5)
		render 'admin/tasks/index'
	end

	def approve_task
		@task.approve
	end

	def find_task
		@task = Task.find(params[:id])
	end
end
