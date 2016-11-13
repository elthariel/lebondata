require 'mechanize'
require 'uri'

require 'lebondata/constants'
require 'lebondata/parser'
require 'lebondata/search'

module LeBonData
  # Main library class, represents a connection to 'Le Bon Coin'
  class Client
    attr_reader :agent, :options

    def initialize(options = {})
      @options = LeBonData::DEFAULT_CLIENT_OPTIONS.dup.merge(options)
      @agent = Mechanize.new
      configure_agent!
    end

    def root
      agent.get(LeBonData::BASE_URL)
    end

    def search(options = {})
      Search.new(self, options)
    end

    def get(url, params = {})
      url = "#{LeBonData::BASE_URL}#{url}"

      unless params.empty?
        url << '?' + params.map do |k, v|
          [k, v].join('=')
        end.join('&')
      end

      puts URI.encode(url)

      agent.get URI.encode(url)
    end

    private

    def configure_agent!
      agent.pluggable_parser.html = LeBonData::Parser

      if options[:user_agent_alias]
        @agent.user_agent_alias = options[:user_agent_alias]
      end
    end
  end
end
