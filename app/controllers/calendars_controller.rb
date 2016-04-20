class CalendarsController < ApplicationController
  load_and_authorize_resource

  def create
    @calendar.user_id = current_user
    if @calendar.save
      flash[:success] = t "calendar.success_create"
      redirect_to root_path
    else
      flash[:danger] = t "calendar.danger_create"
      render :new
    end
  end

  def update
    if @calendar.update_attributes calendar_params
      flash[:success] = t "calendar.success_update"
      redirect_to user_calendars_path current_user
    else
      render :edit
    end
  end

  def destroy
    if @calendar.destroy
      flash[:success] = t "calendars.deleted"
    else
      flash[:danger] = t "calendars.not_deleted"
    end
    redirect_to root_path
  end

  private
  def calendar_params
    params.require(:calendar).permit Calendar::ATTRIBUTES_PARAMS
  end
end