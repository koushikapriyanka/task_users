class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = (current_user.admin? ? Task.all : current_user.tasks)
    if params[:name].present?
      resp = Task.where("name like '%#{params[:name]}%'")
      if resp.present? 
        if !current_user.admin?
          resp = resp.where(:user_id => current_user.id)
        end
        @tasks = resp 
      end
    end  
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @all_status =  {1 => "New", 2 => "In Progress", 3 => "Completed"}.map{|k,v| [v,k] }
  end

  # GET /tasks/1/edit
  def edit
    @all_status =  {1 => "New", 2 => "In Progress", 3 => "Completed", 4 => "Expired", 5 => "Pending Approved", 6 => "Completed and Approved "}.map{|k,v| [v,k] }
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if (current_user.admin? && (task_params[:status].to_i > 4))
        return redirect_to @task, notice: 'Task was not updated. You are not allowed to change Task which in Pending for Approval or Approved'
      end
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.includes(:user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params[:task][:user_id] = current_user.try(:id)
      params.require(:task).permit(:name, :status,:user_id)
    end
end
