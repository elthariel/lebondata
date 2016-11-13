module LeBonData
  # Collection of offers coming from a search page
  class OfferCollection < Array
    attr_reader :client, :page

    def initialize(client, page)
      @client = client
      @page = page
    end
  end
end
