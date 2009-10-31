class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user] 
    @user.nickname = params[:user][:nickname]
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

  def edit_profile
    @user = current_user
  end
  alias edit_account edit_profile

  def update_profile
    update :edit_profile
  end

  def update_account
    update :edit_account
  end
  
  private
    def update(action)
      @user = current_user # makes our views "cleaner" and more consistent
      if @user.update_attributes params[:user] 
        flash[:notice] = Russian.t( action ) + " обновлён!"
        redirect_to :action => action
      else
        render :action => action
      end
    end
end
