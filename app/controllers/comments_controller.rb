class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @tweet = Tweet.find_by(id: params['id'])
    @user = current_user
    @to_user = @tweet.user
  end
  def create
    respond_to do |format|
      if @comment = Comment.create(comment_params)
        @notification = @comment.notifications.create(user_id: @comment.to_user_id, tweet_id: @comment.tweet_id)
        Pusher.trigger("user_#{@comment.to_user_id}_channel", 'comment_created', { message: 'あなたの作成したブログにコメントが付きました' })
        format.html { redirect_to home_url, flash:{success: 'Tweetのコメントを作成しました'} }
      else
        format.html { redirect_to home_url, flash:{error: 'Tweetのコメントに失敗しました'} }
      end
    end

  end
  private
  def comment_params
      params.require(:comment).permit(:comment,:user_id,:tweet_id,:to_user_id)
  end
end
