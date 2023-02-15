class GossipsController < ApplicationController
  before_action :authenticate_user, only: %i[new create]

  def index
    @gossips = Gossip.all.sort_by(&:created_at)
  end

  def show
    @gossip = Gossip.find(params['id'])
    @comment = Comment.new(gossip: @gossip)
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user

    if @gossip.save
      flash[:success] = 'Votre potin a bien été ajouté'
      redirect_to action: 'index'
    else
      flash[:error] = "Votre potin n'a pas pu être créé"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gossip = Gossip.find(params['id'])

    return if user_allowed_to_edit?

    flash[:error] = "Seul l'auteur du potin peut le modifier"
    render :show
  end

  def update
    @gossip = Gossip.find(params[:id])

    if user_allowed_to_edit?
      if @gossip.update(gossip_params)
        flash[:success] = 'Le potin a bien été mis à jour'
        redirect_to @gossip
      else
        flash[:error] = "Le potin n'a pas pu être mis à jour"
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:error] = "Seul l'auteur du potin peut le modifier"
      render :show
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])

    if user_allowed_to_edit?
      @gossip.destroy
      flash[:success] = 'Le potin a bien été supprimé'
      redirect_to action: 'index'
    else
      flash[:error] = "Seul l'auteur du potin peut le modifier"
      render :show
    end
  end

  def like
    @gossip = Gossip.find(params[:id])
    Like.create(user_id: current_user.id, gossip_id: @gossip.id)
    redirect_back fallback_location: root_path
  end

  def unlike
    @gossip = Gossip.find(params[:id])
    @like = @gossip.likes.find_by(user: current_user)
    @like.destroy
    redirect_back fallback_location: root_path
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end

  def authenticate_user
    return if current_user

    flash[:danger] = 'Please log in'
    redirect_to new_session_path
  end

  def user_allowed_to_edit?
    current_user == @gossip.user
  end
end
