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

  def edit
    @gossip = Gossip.find(params['id'])
  end

  def update
    @gossip = Gossip.find(params[:id])

    if @gossip.update(gossip_params)
      flash[:success] = 'Le potin a bien été mis à jour'
      puts 'Gossip updated !'
      redirect_to @gossip
    else
      flash[:error] = "Le potin n'a pas pu être mis à jour"
      puts 'Gossip not updated'
      p @gossip.errors
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    puts 'REACHED METHOD DESTROY'
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:success] = 'Le potin a bien été supprimé'
    redirect_to action: 'index'
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
