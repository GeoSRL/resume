class UsersController < ApplicationController
  def index
  end

  def login
    @users = params[:user]

    if request.post?
      session[:user] = User.authenticate(@users[:email], @users[:password])
      if session[:user]
        redirect_to root_path, :notice => "You've been successfully logged in."
      else
        flash[:error] = "Username and/or password is incorrect. Please try again."
        render :action => :login
      end
    end
  end

  def register
    @users = User.new
  end

  def create
    @users = User.new(params[:user])

    if request.post?
      if @users.save
        redirect_to users_login_path, :notice => "Your account has been created, #{@users.email}"
      else
        render :action => :register
      end
    end
  end

  def destroy
    session[:user] = nil
    
    redirect_to root_path, :notice => "You've been logged out."
  end
end
