class HomeController < ApplicationController
  def index
    @user_email = current_user.email
    @user_organizations = current_user.organizations.map { |o| o.name }
  end
end
