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

class AssociationSet
  attr_reader :collection
  def initialize(collection, type = nil)
    @collection = collection
    type.nil? ? @type = collection.first.class : @type = type
  end

  def build(hash)
    create(hash)
  end

  def collect
    @collection.collect do |object|
      yield(object)
    end
  end

  def create(hash)
    @collection << @type.new(hash)
  end

  def each
    @collection.each do |object|
      yield object
    end
  end

  def size
    @collection.size
  end
end

class Hardware < FromHash
  attr_accessor :id
end

class HardwaresHackdays < FromHash
  attr_accessor :hardware_id

  class << self
    def where(*args)
      self
    end

    def destroy_all(*args)
      self
    end
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
