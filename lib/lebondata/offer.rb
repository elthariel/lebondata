module LeBonData
  # Represents an offer on 'le bon coin'
  class Offer
    BASIC_ATTRIBUTES = %w(category address priceCurrency price
                          availabilityStarts).freeze
    attr_reader :client, :title, :href

    def initialize(client, attributes)
      @client = client
      @attr = attributes.dup

      @title = @attr.delete :title
      @href = @attr.delete :href

      @loaded = false
    end

    def attributes
      @attr
    end

    def [](key)
      if @attr.key? key
        @attr[key]
      elsif !@loaded
        load!
        self[key]
      end
    end

    def page
      @page ||= client.get(href)
    end

    def load!
      @attr.merge! page.offer_attributes
    end
  end
end
