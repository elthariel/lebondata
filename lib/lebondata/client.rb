require 'mechanize'
require 'uri'

require 'lebondata/constants'
require 'lebondata/parser'
require 'lebondata/search'
require 'lebondata/offer_collection'

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
      OfferCollection.new Search.new(self, options)
    end

    def get(url, params = {})
      url = "#{LeBonData::BASE_URL}#{url}" unless url =~ %r{^https?://}
      puts 'url = ', url

      unless params.empty?
        url << '?' + params.map do |k, v|
          [k, v].join('=')
        end.join('&')
      end

      puts URI.encode(url)

      agent.get URI.encode(url)
    end

    private

    def throttle!
      next_time = @next_request_at || Time.now.to_f
      now = Time.now.to_f

      sleep(next_time - now) if now < next_time

      @next_request_at = Time.now.to_f + random_sleep_time
    end

    def random_sleep_time
      target_sleep_time = 1.0 / @options[:throttle]
      random = rand * target_sleep_time

      target_sleep_time + random - target_sleep_time / 2.0
    end

    # Called by Mechanize agent before each connection.
    def pre_connect(request)
      return unless request['Host'] == URI(LeBonData::BASE_URL).host

      throttle! if @options[:throttle]
    end

    def configure_agent!
      agent.pluggable_parser.html = LeBonData::Parser

      if options[:user_agent_alias]
        @agent.user_agent_alias = options[:user_agent_alias]
      end

      agent.pre_connect_hooks << lambda do |_a, req|
        pre_connect req
      end
    end
  end
end
