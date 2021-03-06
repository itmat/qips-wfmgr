# Settings specified here will take precedence over those in config/environment.rb

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_loading            = true

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

# testing gems!
config.gem 'rspec-rails', :version => '>= 1.3.2', :lib => false unless File.directory?(File.join(Rails.root, 'vendor/plugins/rspec-rails'))
config.gem "rspec", :lib => false, :version => ">=1.2.9"
config.gem "cucumber", :lib => false, :version => ">=0.4.3"
config.gem "pickle", :lib => false, :version => ">=0.1.21"
config.gem 'cucumber-rails',   :lib => false, :version => '>=0.3.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/cucumber-rails'))
config.gem 'database_cleaner', :lib => false, :version => '>=0.5.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/database_cleaner'))
config.gem 'webrat',           :lib => false, :version => '>=0.7.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/webrat'))
config.gem "capybara", :lib => false, :version => "=0.3.8"



# Use SQL instead of Active Record's schema dumper when creating the test database.
# This is necessary if your schema can't be completely dumped by the schema dumper,
# like if you have constraints or database-specific column types
# config.active_record.schema_format = :sql

RMGR_CMD = "curl -I --basic -u 'admin:admin' http://localhost:3001/farms/start_by_role"

#scratch space for s3
S3_SCRATCH_SPACE = "daustin-test:qips_scratch/"

#active resource site
RMGR_SITE = 'http://admin:admin@localhost:3001'

#active resource lims site
ILIMS_SITE = 'http://admin:admin@localhost:3002'

# how long wfmgr waits between executing each task.  set to at least 60 seconds in production for use wih qips-node
PROCESS_WAIT_TIME = 5

# wget command.  must be quiet and output to stdout. and not check certs
WGET_CMD = 'wget -q --no-check -O -' 

# public link to lims site
PUBLIC_ILIMS_SITE = 'http://localhost:3002'
