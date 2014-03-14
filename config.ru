require './app'

require './helpers/application_helper'
require './helpers/form_helper'

require './models/person'
require './models/brand'

require './controllers/application_controller'
require './controllers/users_controller'
require './controllers/brands_controller'


map('/') { run ApplicationController }
map('/users') { run UsersController }
map('/brands') { run BrandsController }

