class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
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
    @gossip.user = User.first

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
  end

  def update
    @gossip = Gossip.find(params[:id])
    p @gossip.tags

    if @gossip.update(gossip_params)
      flash[:success] = 'Le potin a bien été mis à jour'
      redirect_to @gossip
    else
      flash[:error] = "Le potin n'a pas pu être mis à jour"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:success] = 'Le potin a bien été supprimé'
    redirect_to action: 'index'
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end
end
