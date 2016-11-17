require 'mechanize'

module LeBonData
  # Our mechanize parser with helpers to find offer lists and content
  class Parser < Mechanize::Page
    def offers_count
      at('nav.fl').at('a:first').at('span').text.gsub(/\s/, '').to_i
    end

    def offers_attributes
      @offers ||= search(LeBonData::OFFERS_SELECTOR).map do |offer|
        a = offer.at('./a')

        result = {
          href: 'https:' + a.attributes['href'].value,
          title: a.attributes['title'].value
        }

        a.search('[@itemprop]').each do |prop|
          next unless prop.attributes['content']

          key = prop.attributes['itemprop'].value.to_sym
          value = prop.attributes['content'].value

          if result[key]
            result[key] = [result[key]] unless result[key].is_a? Array
            result[key] << value
          else
            result[key] = value
          end
        end

        result
      end
    end

    def offer_attributes
      offer_node = at(LeBonData::OFFER_SELECTOR)

      attr = {
        img: offer_image,
        description: offer_node.at('[@itemprop="description"]').text
      }.merge offer_lines(offer_node)

      attr
    end

    def offer_lines(offer_node)
      attr = {}

      offer_node.search('.line').each do |node|
        property_node = node.at('span.property')
        value_node = node.at('span.value')

        if property_node && value_node
          key = normalize_line_key property_node.text
          attr[key] = normalize_line_value value_node.text
        end
      end

      attr
    end

    def offer_image
      img = at('[@itemprop="image"]')

      'https:' + img.attributes['content'].value if img
    end

    private

    def normalize_line_key(str)
      I18n.transliterate(str)
        .gsub(/^\s+/, '')
        .gsub(/\s+$/, '')
        .downcase.gsub(/\W+/, '_')
        .to_sym
    end

    def normalize_line_value(str)
      str.gsub(/^\s+/, '')
        .gsub(/\s+$/, '')
    end

  end
end
