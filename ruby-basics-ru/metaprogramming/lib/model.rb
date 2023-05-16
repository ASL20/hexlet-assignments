# frozen_string_literal: true

# BEGIN
module Model
  SYMBOL_CLASSES = {
    integer: Integer,
    string: String,
    datetime: DateTime,
    boolean: [TrueClass]
  }

  module ClassMethods
    def attribute(name, options = {})
      define_method name do
        converted_name = 
          
        self.instance_variable_get "@#{name}"
      end
      
      define_method "#{name}=" do |value|
        self.instance_variable_set "@#{name}", value
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(options = {})
    @options = options.select { |k, v| self.respond_to?("#{k}=")}
  
    @options.each do |key, value|
      self.instance_variable_set "@#{key}", value
    end
  end

  def attributes
    @options.each_with_object({}) do |pair, obj|
      obj[pair.first] = self.send(pair.first)
    end  
  end
end
# END
