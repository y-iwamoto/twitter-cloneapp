class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.paginate(page: params[:page], :per_page => 30)
    @search = User.ransack(params[:q])
  end
  def show
    if params[:q].blank? && session[:search_q].present?
      params[:q] = session[:search_q]
    end

    @search = User.ransack(params[:q])
    session[:search_q] = params[:q]

    @users = @search.result.paginate(page: params[:page], :per_page => 30)
    if @users.count != 0
      flash.clear
      render controller: 'users', action: 'index'
    else
      flash[:error] = "ユーザが１件も見つかりません"
      render controller: 'users', action: 'index'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 30)
    @search = User.search(params[:q])
    render controller: 'users', action: 'index'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 30)
    @search = User.search(params[:q])
    render controller: 'users', action: 'index'
  end
end
