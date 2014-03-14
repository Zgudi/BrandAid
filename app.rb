require 'rubygems'
require 'sinatra'

require 'mongo'
require 'mongoid'

require 'json'
require 'sass'
require 'haml'

require 'rack-flash'
require 'sinatra/redirect_with_flash'

configure do
  Mongoid.load!('mongoid.yml')
end

#TODO
helpers do
  def upload(filename, file)
    bucket = 'bucket_name'
    AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['ACCESS_KEY_ID'],
        :secret_access_key => ENV['SECRET_ACCESS_KEY']
    )
    AWS::S3::S3Object.store(
        filename,
        open(file.path),
        bucket
    )
    return filename
  end
end

#TODO
#upload logo to Amazon S3
#API & Generated CSS