module LeBonData
  # Base url for 'le bon coin'
  BASE_URL = 'https://www.leboncoin.fr'.freeze

  # The defauult client options
  DEFAULT_CLIENT_OPTIONS = {
    user_agent_alias: 'Mac Firefox'
  }.freeze

  DEFAULT_SEARCH_OPTIONS = {
    category: 'annonces',
    region: 'ile_de_france',
    ad_type: 'offres'
  }.freeze

  OFFERS_PER_PAGE = 35
  OFFERS_SELECTOR = './/li[@itemtype="http://schema.org/Offer"]'.freeze
  OFFER_SELECTOR = 'section.properties'.freeze
end
