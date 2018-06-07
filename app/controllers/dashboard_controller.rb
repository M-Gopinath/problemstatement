class DashboardController < ApplicationController
  def index
    @user_comment = UserComment.new
    @comments = UserComment.active.where(visibility: ['partially_visible', 'visible']).order("created_at DESC")
  end
end
