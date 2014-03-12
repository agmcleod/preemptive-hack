require 'base_spec_helper'
Dir[File.join(RAILS_ROOT, "spec/support_models/**/*.rb")].each {|f| require f}
ActiveSupport::Dependencies.autoload_paths << "#{RAILS_ROOT}/app/models"