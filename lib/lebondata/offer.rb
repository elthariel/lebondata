module LeBonData
  # Represents an offer on 'le bon coin'
  class Offer
    attr_reader :client, :title, :href

    def initialize(client, title, href, attributes)
      @client = client
      @title = title
      @href = href
      @attr = attributes
    end
  end
end
