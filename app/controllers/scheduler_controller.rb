class SchedulerController < ApplicationController
  def assign_route
    unless params[:organization].blank?
      @organization = Organization.find_by(id: params[:organization])
      unless @organization.blank?
        request_assignations = []
        all_routes = Route.order('starts_at ASC').by_organization(@organization.name)

        all_routes.each_with_index do |routes, index|
          request_assignations << params["route-#{index}"]
        end

        request_assignations.each_with_index do |request, index|
          new_value = request.blank? ? nil : Vehicle.find_by(plate: request.split(" / ").last).id

          all_routes[index].update!(vehicle_id: new_value) unless all_routes[index].vehicle_id == new_value
        end
      end
    end
    return redirect_to organization_routes_scheduler_index_path(organization: params[:organization])
  end
  
  def organization_routes
    @user_organizations = current_user.organizations
    @message = "User has #{@user_organizations.count} organization#{@user_organizations.count > 1? 's' : ''} to select" if params[:organization].blank? && !@user_organizations.blank?
    @max_hours = ((Route.max_datetime(Date.today) - Route.min_datetime(Date.today)) * 24).to_i
    
    unless params[:organization].blank?
      @organization = Organization.find_by(id: params[:organization])
      unless @organization.blank?
        @all_routes = Route.order('starts_at ASC').by_organization(@organization.name)
        @message =  @all_routes.nil? ? "No routes found" : "#{@all_routes.count} routes were found"
        @colors = %w[blue indigo red orange yellow green teal purple cyan pink]
      else
        @message = "The organization entered is not valid"
      end
    end
  end
end
