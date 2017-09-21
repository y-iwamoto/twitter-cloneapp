class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  def index
    @user = current_user
    @feed_items = current_user.feed.paginate(page:params[:page])
    @tweet = current_user.tweets.build
  end
  WillPaginate.per_page = 10
end
