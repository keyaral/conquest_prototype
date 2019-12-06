class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :assign, :complete]
  before_action :must_be_admin, only: [:new, :create, :edit, :update ]


  def assign
    @activity.assignee_id = current_user.id
    @activity.save
    redirect_to @activity, notice: 'Activity was successfully assigned.'
  end

  def complete
    if current_user != @activity.user
      return redirect_back fallback_location: { action: "index" }, notice: 'This activity is not assigned to you'
    end
    @activity.update!(completed: true)
    redirect_to @activity, notice: 'Activity was successfully completed.'
  end

  def index
      @activities = Activity.where(completed: false)
      @completed_activities = Activity.where(completed: true)
  end

  def user_assigned
    user_activities = current_user.assigned_activities
    @activities = user_activities.reject{ |x| x.completed }
    @completed_activities =  user_activities.select{ |x| x.completed }
    render :user_index
  end

  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :description, :score_value)
    end

    def must_be_admin
      if current_user.user?
        return redirect_to activities_path, notice: 'You are not authorised to perform that task'
      end
    end
end
