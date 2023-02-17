class LikesController < ApplicationController
  before_action :find_likeable, only: %i[new create destroy]

  def new
    @like = Like.new
  end

  def create
    p @likeable
    @like = @likeable.likes.new(user: current_user)
    if @like.save
      flash[:success] = "Merci d'aimer !"
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    puts 'X' * 30
    p params
    puts 'X' * 30
    p current_user
    puts 'X' * 30
    p @likeable

    @like = @likeable.likes.find_by(user: current_user)
    @like.destroy
    flash[:success] = "Vous n'aimez plus ce contenu !"
    redirect_back fallback_location: root_path
  end

  private

  def find_likeable
    @likeable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @likeable = Gossip.find_by_id(params[:gossip_id]) if params[:gossip_id]
    @likeable = User.find_by_id(params[:user_id]) if params[:user_id]
    @likeable = Tag.find_by_id(params[:tag_id]) if params[:tag_id]
    @likeable = City.find_by_id(params[:city_id]) if params[:city_id]
  end
end
