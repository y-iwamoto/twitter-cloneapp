class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  def index
    @user = current_user
    @users_recomend = User.where("id IN (?) AND id NOT IN (?)",User.pluck(:id).shuffle[0..2],current_user.id)
    @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 10)
    @tweet = current_user.tweets.build
  end
end
