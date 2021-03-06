require 'lebondata/constants'

module LeBonData
  # class representing a search on 'le bon coin'
  class Search
    attr_reader :client, :options
    attr_reader :region, :category, :ad_type

    def initialize(client, options = {})
      @client = client
      @options = LeBonData::DEFAULT_SEARCH_OPTIONS.dup.merge(options)

      @category = @options.delete(:category)
      @region = @options.delete(:region)
      @ad_type = @options.delete(:ad_type)

      @pages = {}
    end

    def page(page_id = 1)
      url = "/#{category}/#{ad_type}/#{region}/"
      params = options.dup.merge o: page_id

      @pages[page_id] ||= client.get(url, params)
    end
  end
end
