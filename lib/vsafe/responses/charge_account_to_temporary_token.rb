require "vsafe/response"
require "vsafe/card_type"

module VSafe
  module Responses
    class ChargeAccountToTemporaryToken < Response
      define_attribute_mapping(:token, "ChargeAccountNumberToken")
      define_attribute_mapping(:last4, "PaymentDeviceLast4")
      define_attribute_mapping(:card_type, "PaymentDeviceTypeCD", CardType)
    end
  end
end
