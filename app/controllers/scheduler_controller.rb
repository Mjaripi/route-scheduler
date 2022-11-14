class SchedulerController < ApplicationController
  MAX_PAG = 6

  def assign_route
    unless params[:organization].blank?
      @organization = Organization.find_by(id: params[:organization])
      unless @organization.blank?
        changed_routes = []
        conflict_routes = []
        found_keys = params.keys.grep(/^route-/)
        request_assignations = found_keys.map { |route| params[route] } unless found_keys.blank?

        request_assignations.each_with_index do |request, index|
          new_value = request.blank? ? nil : Vehicle.find_by(plate: request.split(' / ').last)
          found_route = Route.find_by(id: found_keys[index].split('-').last)
          next if found_route.vehicle_id == new_value

          if new_value.nil?
            found_route.update(vehicle_id: new_value)
            changed_routes << found_route
            next
          end

          if new_value.routes.select { |route| route.route_colision?(found_route) }.blank?
            found_route.update(vehicle_id: new_value.id)
            changed_routes << found_route
          else
            conflict_routes << found_route
          end
        end
      end
    end
    flash[:alert] = t('scheduler.conflict_notices', count: conflict_routes.count) unless conflict_routes.blank?
    flash[:notice] = t('scheduler.notice_changes', count: changed_routes.empty? ? 0 : changed_routes.count)
    redirect_to organization_routes_scheduler_index_path(organization: params[:organization], selected_date: params[:selected_date])
  end

  def organization_routes
    @user_organizations = current_user.organizations
    @message =  t('scheduler.organizations_found', count: @user_organizations.count)
    @max_hours = ((Route.max_datetime(Date.today) - Route.min_datetime(Date.today)) * 24).to_i
    return if params[:organization].blank?

    @organization = Organization.find_by(id: params[:organization])
    @message = t('scheduler.organization_not_valid') unless @organization.blank?
    return if @organization.blank?

    @selected_date = params[:selected_date].to_date
    @all_drivers = @organization.drivers.assigned.map { |d| d.assigned_vehicle }
    @all_routes = Kaminari.paginate_array(Route.order('starts_at ASC').by_organization(@organization.name).select { |r| r.starts_at.to_date == @selected_date }).page(params[:page]).per(MAX_PAG)
    @message =  t('scheduler.routes_found', count: @all_routes.count)
    @colors = %w[blue indigo red orange yellow green teal purple cyan pink]
  end

end
