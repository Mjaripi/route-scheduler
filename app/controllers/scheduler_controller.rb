class SchedulerController < ApplicationController
  def assign_route
    puts "/////////#{params.inspect}"
    redirect_to organization_routes_scheduler_index_path(organization: params[:organization])
  end

  def organization_routes
    @user_organizations = current_user.organizations.map { |o| o.name }
    @message = "User has #{@user_organizations.count} organization#{@user_organizations.count > 1? 's' : ''} to select" if params[:organization].blank? && !@user_organizations.blank?

    unless params[:organization].blank?
      @organization = Organization.find_by(name: params[:organization])
      unless @organization.blank?
        @all_routes = Route.by_organization(@organization.name)
        @message =  @all_routes.nil? ? "No routes found" : "#{@all_routes.count} routes were found"
        @all_drivers = @organization.drivers.assigned.map { |d| d.assigned_vehicle }
        @all_drivers.unshift("Unassigned")
        @colors = %w[blue purple indigo pink red orange yellow green teal cyan]
      else
        @message = "The organization entered is not valid"
      end
    end
  end
end
