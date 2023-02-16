class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    puts params[:session][:email]

    if user && user.authenticate(params[:session][:password])
      puts 'LOGGED IN'
      log_in(user)
      cookies.each do |cookie|
        p cookie
      end
      if params[:session][:rememeber] == 1
        puts "REMEMBERING USER BECAUSE #{params[:session][:remember]}"
        remember(user)
      end
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
    log_out(current_user)
    redirect_to root_path
  end
end
