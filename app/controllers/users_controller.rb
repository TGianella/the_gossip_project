class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    p @user

    if @user.save
      login(@user)
      flash[:success] = 'Votre compte a bien été créé'
      redirect_to root_path
    else
      flash[:error] = "Votre compte n'a pas pu être créé"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params['id'])
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :age,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :city_id, :description)
  end
end
