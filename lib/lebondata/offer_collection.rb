require 'lebondata/offer'

module LeBonData
  # Collection of offers coming from a search page
  class OfferCollection < Array
    attr_reader :search

    include Enumerable

    def initialize(search)
      @search = search
    end

    def count
      @count ||= search.page.offers_count
    end

    def [](idx)
      return nil if idx >= count

      page = idx / LeBonData::OFFERS_PER_PAGE + 1
      idx_in_page = idx % LeBonData::OFFERS_PER_PAGE

      LeBonData::Offer.new search.client,
                           search.page(page).offers_attr[idx_in_page]
    end

    def each
      if block_given?
        pages = count / LeBonData::OFFERS_PER_PAGE + 1
        1.upto(pages) do |page_id|
          search.page(page_id).offers_attrs.each do |attr|
            yield LeBonData::Offer.new(search.client, attr)
          end
        end
      end
    end

  end
end
