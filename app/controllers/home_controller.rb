class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @novels = current_user.novels
  end
end
