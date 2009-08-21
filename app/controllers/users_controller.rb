class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user] 
    @user.login = params[:user][:login]
    @user.sex ||= Sex.undefined
    if @user.save
      flash[:notice] = "Пользователь зарегистрирован"
      redirect_back_or_default user_url( @user )
    else
      render :action => :new
    end
  end

  def show
    @user = params[:id] ? User.find( params[:id] ) : current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes params[:user] 
      flash[:notice] = "Профиль обновлен!"
      redirect_to user_url( @user )
    else
      render :action => :edit
    end
  end
end
