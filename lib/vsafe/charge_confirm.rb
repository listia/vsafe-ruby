require "vsafe/response"
require "vsafe/payment_status"

module VSafe
  module Responses
    class ChargeConfirm < Response
      define_attribute_mapping(:payment_status, "PaymentStatus", PaymentStatus)
    end
  end
end
