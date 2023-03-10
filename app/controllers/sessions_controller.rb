class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    puts params[:session][:email]

    if user && user.authenticate(params[:session][:password])
      puts 'LOGGED IN'
      log_in(user)
      remember(user) if params[:session][:remember] == '1'
      flash[:success] = 'Connexion réussie !'
      redirect_to root_path
    else
      puts 'NOT LOGGED IN'
      flash[:alert] = 'Combinaison email/mot de passe invalide'
      render :new
    end
  end

  def destroy
    puts 'DESTROYING SESSION'
    log_out(current_user)
    redirect_to root_path
  end
end
