class SchedulerController < ApplicationController
  def index
    @organization = Organization.find_by(name: params[:organization])
    @all_routes = Route.by_organization(@organization.name)
    @all_drivers = @organization.drivers.assigned.map { |d| d.assigned_vehicle }
  end

  def assign_route

    redirect_to scheduler_index_path
  end


end
