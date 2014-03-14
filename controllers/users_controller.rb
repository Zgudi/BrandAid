class UsersController < ApplicationController

  ['/edit', '/update', '/sign_out', '/profile', '/new_password', '/reset_password'].each do |path|
    before path do
      redirect "/users/login_info" unless current_user.present?
    end
  end

  ['/new', '/create'].each do |path|
    before path do
      redirect "/index" if current_user.present?
    end
  end

  get "/new" do
    @person = Person.new
    haml :"users/new"
  end

  post "/create" do
    @person = Person.new(params[:person])
    if @person.save
      redirect "/users/register_info"
    else
      haml :"users/new"
    end
  end

  get "/edit" do
    @person = current_user
    haml :"users/edit"
  end

  post "/update" do
    @person = current_user
    if @person.update_attributes(params[:person])
      flash[:success] = "Your account has been updated!"
      redirect "/users/profile"
    else
      flash[:error] = "You can't update your account."
      haml :"users/edit"
    end
  end

  get "/login" do
    @person = Person.new
    haml :"users/login"
  end

  post "/authenticate" do
    @person = Person.where(:login => params[:person][:login]).first
    if @person.present?
      if @person.password == params[:person][:password]
        session[:user_id] = @person.id
        redirect "/index"
      end
    end
    @person = Person.new
    flash[:error] = 'Invalid Login or Password!'
    haml :"users/login"
  end

  get "/sign_out" do
    if current_user.present?
      session[:user_id] = nil
      haml :"users/logout_info"
    else
      redirect "/index"
    end
  end

  get "/profile" do
    @person = current_user
    haml :"users/profile"

  end

  get "/new_password" do
    @person = Person.new
    haml :"users/new_password"
  end

  post "/reset_password" do
    @person = current_user
    @person.attributes = { :password => params[:person][:password], :confirm_password => params[:person][:confirm_password] }
    if @person.save
      flash[:success] = "Your password has been changed successfully!"
      redirect "/users/profile"
    else
      flash[:error] = "Your can't change password."
      haml :"users/new_password"
    end
  end

  get "/login_info" do
    haml :"users/login_info"
  end

  get "/register_info" do
    haml :"users/register_info"
  end
end

