class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    @user.authenticate(params[:session][:password])

    if @user && @user.authenticate(params[:session][:password])
      puts 'LOGGED IN'
      session[:user_id] = @user.id
      flash[:success] = 'Connexion réussie !'
      redirect_to root_path
    else
      puts 'NOT LOGGED IN'
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    puts 'DESTROYING SESSION'
    session.delete(:user_id)
    redirect_to root_path
  end
end
