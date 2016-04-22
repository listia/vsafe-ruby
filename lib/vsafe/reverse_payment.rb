require "vsafe/response"
require "vsafe/payment_status"

module VSafe
  module Responses
    class ReversePayment < Response
      define_attribute_mapping(:available_refund_amount, "AvailableRefundAmount")
      define_attribute_mapping(:payment_acquirer_name, "PaymentAcquirerName")
      define_attribute_mapping(:payment_id, "PaymentID")
    end
  end
end
