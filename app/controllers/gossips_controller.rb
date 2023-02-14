class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params['id'])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = User.first

    if @gossip.save
      flash[:success] = 'Votre potin a bien été ajouté'
      puts 'Gossip created !'
      redirect_to action: 'index'
    else
      flash[:error] = "Votre potin n'a pas pu être créé"
      puts 'Gossip not created !'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
