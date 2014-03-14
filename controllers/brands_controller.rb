class BrandsController < ApplicationController

  ['/index', '/new', "/create", "/show", "/edit", "/update", "/destroy"].each do |path|
    before path do
      redirect "/users/login_info" unless current_user.present?
    end
  end

  ["/show", "/edit", "/update", "/destroy"].each do |path|
    before path do
      if params[:id].present?
        @brand = Brand.find(params[:id])
        if @brand.present?
          if @brand.person_id.to_s == current_user.id.to_s
            break
          end
        end
      end
      redirect "/brands/not_exist"
    end
  end

  get "/index" do
    @brands = Brand.where(:person_id => current_user.id).all
    haml :"brands/index"
  end

  get "/new" do
    @brand = Brand.new
    haml :"brands/new"
  end

  post "/create" do
    @brand = Brand.new(params[:brand])
    if @brand.save
      @brand.update_attributes(:person_id => current_user.id)
      flash[:success] = "Your Brand named #{@brand.name} has been created!"
      redirect :"/brands/show?id=#{@brand.id}"
    else
      flash[:error] = "Your Brand can't be create."
      haml :"brands/new"
    end
  end

  get "/show" do
    @brand = Brand.find(params[:id])
    haml :"brands/show"
  end

  get "/edit" do
    @brand = Brand.find(params[:id])
    haml :"brands/edit"
  end

  post "/update" do
    @brand = Brand.find(params[:id])
    remove_attributes([:colors, :colors_usage, :taglines, :taglines_usage, :fonts])
    @www = params
    if @brand.update_attributes(params[:brand])
      flash[:success] = "Your Brand has been updated!"
      redirect :"/brands/show?id=#{@brand.id}"
    else
      flash[:error] = "Your Brand can't be update."
      haml :"brands/edit"
    end
  end

  get "/destroy" do
    @brand = Brand.find(params[:id])
    name =  @brand.name
    @brand.destroy
    flash[:success]= "Your Brand named #{name} has been destroyed!"
    redirect "/brands/index"
  end

  get "/not_exist" do
    haml :"brands/not_exist"
  end

  private

  def remove_attributes(options = [])
    options.each do |option|
      if params[:brand][:"#{option.to_s}"].nil?
        params[:brand][:"#{option.to_s}"] = nil
      end
    end
  end
end

