require 'mechanize'

module LeBonData
  # Our mechanize parser with helpers to find offer lists and content
  class Parser < Mechanize::Page
    def offers
      @offers ||= search(LeBonData::OFFERS_XPATH).map do |offer|
        a = offer.at('./a')

        result = {
          href: 'https:' + a.attributes['href'].value,
          title: a.attributes['title'].value
        }

        a.search('[@itemprop]').each do |prop|
          key = prop.attributes['itemprop'].value
          if prop.attributes['content']
            result[key] = prop.attributes['content'].value
          end
        end

        result
      end
    end
  end
end
