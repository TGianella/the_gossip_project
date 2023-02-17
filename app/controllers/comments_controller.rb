class CommentsController < ApplicationController
  before_action :find_commentable, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Votre commentaire a bien été ajouté'
      redirect_to @commentable
    else
      flash[:error] = "Votre commentaire n'a pas pu être créé"
      redirect_back fallback_location: root_path
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = 'Le commentaire a bien été mis à jour'
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Le commentaire n'a pas pu être mis à jour"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Le commentaire a bien été supprimé'
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Gossip.find_by_id(params[:gossip_id]) if params[:gossip_id]
  end
end
