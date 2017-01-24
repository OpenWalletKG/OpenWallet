# Load DSL and set up stages
require "capistrano/setup"
require 'dotenv/load'

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Capistrano rails
require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/rails/assets'
require 'capistrano/puma'
require 'capistrano/rails/console'
require 'airbrussh/capistrano'
require 'capistrano/puma/nginx'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
