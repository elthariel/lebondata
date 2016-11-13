require 'lebondata/version'

require 'lebondata/constants'
require 'lebondata/client'

require 'i18n'

I18n.config.enforce_available_locales = false unless defined?(Rails)

# Main module
module LeBonData
end
