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
    @gossip = Gossip.new(params.require(:gossip).permit(:title, :content))

    if @gossip.save
      puts 'Gossip created !'
      redirect_to action: 'index'
    else
      puts 'Gossip not created !'
      render :new
    end
  end
end
