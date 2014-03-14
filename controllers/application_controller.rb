# encoding: utf-8
$:.unshift(File.expand_path('../../lib', __FILE__))
class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash

  helpers ApplicationHelpers
  helpers FormHelpers

  set :public, 'public'
  set :views, File.expand_path('../../views', __FILE__)

  get "/" do
    redirect "/index"
  end

  get "/index" do
    haml :"/index"
  end

  get "/add_ajax_element" do
    @id = params[:id].to_i + 1
    @group_id =  params[:group_id].to_i
    @brand = Brand.new
    string = haml :"brands/#{params[:type]}", :layout => false
    content_type :json
    { :input_content => string, :input_type => params[:type], :input_group_id =>  @group_id, :input_id => params[:id]}.to_json
  end

  def current_user
    if session[:user_id].present?
      Person.find(session[:user_id])
    else
      nil
    end
  end

end