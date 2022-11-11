class SchedulerController < ApplicationController
  def index
    @user_email = current_user.email
    @user_organizations = current_user.organizations.map { |o| o.name }
  end

  def assign_route
    puts "/////////#{params.inspect}"
    redirect_to organization_routes_scheduler_index_path(organization: params[:organization])
  end

  def organization_routes
    return redirect_to root_path if params[:organization].blank?
    return redirect_to root_path if Organization.where(name: params[:organization]).blank?

    @colors = %w[blue purple indigo pink red orange yellow green teal cyan]
    @organization = Organization.find_by(name: params[:organization])
    @all_routes = Route.by_organization(@organization.name)
    @all_drivers = @organization.drivers.assigned.map { |d| d.assigned_vehicle }
    @all_drivers.unshift("Unassigned")
  end
end
