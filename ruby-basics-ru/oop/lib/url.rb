# frozen_string_literal: true

# BEGIN
# class Url
#   include Forwardable
  
#   def initialize(query_string)
#     @query_string = query_string
#   end

#   def host
#     Url
#   end
  
#   def scheme
#     query_string.slice(\w+(?=\:\/\/))
#   end

#   def port
#     (?<=:)[\d]+(?=\??)
#   end

#   def query_params
#     query_string.scan(/(\w+)=(\w+)/).to_h
#   end

#   def query_param(key, default_value = nil)
#     query_params.fetch(key, default_value)
#   end

#   private

#   def get_host
#     query_string.slice(/(?<=\/\/)[\w\.-]*(?=\:?\??)/)
#   end

#   def get_scheme
#     query_string.slice(\w+(?=\:\/\/))
#   end

#   def get_query_params
#     query_string.scan(/(\w+)=(\w+)/).to_h
#   end

#   def get_port
#     query_string.slice(/(?<=:)[\d]+(?=\??)/)
#   end
# end
require 'uri'

class Url
  include Comparable
  extend Forwardable
  
  def initialize(query_string)
    @url = URI(query_string)
  end

  def_delegators :@url, :scheme, :host, :port

  def query_params
    return {} unless url.query

    params_array = url.query.scan(/(\w+)=(\w+)/)
    @query_params ||= params_array.reduce({}) { |obj, arr| obj[arr[0].to_sym] = arr[1]; obj }
  end

  def query_param(key, default_value = nil)
    query_params.fetch(key, default_value)
  end

  def ==(other)
    scheme == other.scheme && host == other.host && port == other.port && query_params == other.query_params
  end

  private

  attr_reader :url
end
# END
