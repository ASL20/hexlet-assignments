# frozen_string_literal: true

# BEGIN
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

    @query_params ||= url.query.scan(/(\w+)=(\w+)/).to_h.transform_keys(&:to_sym)
  end

  def query_param(key, default_value = nil)
    query_params.fetch(key, default_value)
  end

  def ==(other)
    [scheme, host, port, query_params] == [other.scheme, other.host, other.port, other.query_params]
  end

  private

  attr_reader :url
end
# END
