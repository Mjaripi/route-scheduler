class SchedulerController < ApplicationController
  MAX_PAG = 6

  def assign_route
    unless params[:organization].blank?
      @organization = Organization.find_by(id: params[:organization])
      unless @organization.blank?
        found_keys = params.keys.grep(/^route-/)
        request_assignations = found_keys.map { |route| params[route] } unless found_keys.blank?

        request_assignations.each_with_index do |request, index|
          new_value = request.blank? ? nil : Vehicle.find_by(plate: request.split(" / ").last).id
          found_route = Route.find_by(id: found_keys[index].split('-').last)
          found_route.update!(vehicle_id: new_value) unless found_route.vehicle_id == new_value
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
        @all_routes = Kaminari.paginate_array(Route.order('starts_at ASC').by_organization(@organization.name))
        @page_routes = Kaminari.paginate_array(Route.order('starts_at ASC').by_organization(@organization.name)).page(params[:page]).per(MAX_PAG)
        @message =  @all_routes.nil? ? "No routes found" : "#{@all_routes.count} routes were found"
        @colors = %w[blue indigo red orange yellow green teal purple cyan pink]
      else
        @message = "The organization entered is not valid"
      end
    end
  end
end
