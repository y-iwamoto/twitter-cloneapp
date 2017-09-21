class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:destroy,:edit,:update]
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "Tweetを作成しました"
      redirect_to root_url
    else
      flash[:error] = "Tweetの作成に失敗しました"
      redirect_to root_url
    end
  end

  def edit
  end

  def destroy
    if @tweet.destroy
      flash[:success] = "Tweetを削除しました"
      redirect_to root_url
    else
      flash[:error] = "Tweetの削除に失敗しました"
      redirect_to root_url
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to root_url, flash:{success: 'Tweetを更新しました'} }

      else
        format.html { redirect_to root_url, flash:{error: 'Tweetの更新に失敗しました'} }

      end
    end
  end

  private
    def tweet_params
      params.require(:tweet).permit(:content)
    end
    def correct_user
      @tweet = current_user.tweets.find_by(id: params[:id])
      redirect_to root_url if @tweet.nil?
    end
end
