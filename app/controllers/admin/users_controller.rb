class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_root_path, notice: "#{@user.email} created sucessfully!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_root_path, notice: "#{@user.email} updated sucessfully!"
    else
      render :edit
    end
  end

  protected
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password,
                                 :password_confirmation, :admin)
  end
end
