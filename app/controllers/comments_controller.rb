class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.gossip = Gossip.find(params[:id])

    if @comment.save
      flash[:success] = 'Votre commentaire a bien été ajouté'
      redirect_to @comment.gossip
    else
      flash[:error] = "Votre commentaire n'a pas pu être créé"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = 'Le commentaire a bien été mis à jour'
      redirect_to @comment.gossip
    else
      flash[:error] = "Le commentaire n'a pas pu être mis à jour"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Le commentaire a bien été supprimé'
    redirect_to @comment.gossip
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
