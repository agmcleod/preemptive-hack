require 'rspec'

def app_require(file)
  require File.expand_path(file)
end

class FromHash
  def initialize(h = {})
    h.each do |k, v|
      send("#{k}=".to_sym, v)
    end
  end
end

class Hardware < FromHash
  attr_accessor :id
end

class HardwareHackdays < FromHash
  attr_accessor :hardware_id
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
