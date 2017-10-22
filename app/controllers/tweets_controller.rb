class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:destroy,:edit,:update]
  def create
    @tweet = current_user.tweets.build(tweet_params)
    @notification = @tweet.notifications.build(user_id: @tweet.user.id )
    if @tweet.save
      Pusher.trigger("user_#{@tweet.user_id}_channel", 'comment_created', { message: 'あなたの作成したブログにコメントが付きました' })
      flash[:success] = "Tweetを作成しました"
      redirect_to home_url
    else
      flash[:error] = "Tweetの作成に失敗しました"
      redirect_to root_url
    end
  end

  def show
    if params[:notification_id]
      @notification = Notification.find(params[:notification_id])
      @notification.update(read: true)
      @tweet = Tweet.find_by(id: params[:id])
      @comments = Comment.where(tweet_id:@tweet.id).limit(10)
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
