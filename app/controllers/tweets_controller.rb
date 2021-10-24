class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    #ログイン中にしたツイートリンクが表示されないのでsession[:user_id]が空であることは考慮しなくてよい
    user = User.find_by(uid: current_user)
    @tweet = Tweet.new(message: params[:tweet][:message], user_id: current_user.id)
    if @tweet.save
      flash[:notice] = "ツイートしました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    flash[:notice] = "ツイートを削除しました"
    redirect_to root_path
  end
end
