require "vsafe/response"

module VSafe
  module Responses
    class GetPaymentStatus < Response
      define_attribute_mapping(:amount, "Amount")
      define_attribute_mapping(:payment_id, "PaymentID")
      define_attribute_mapping(:payment_status, "PaymentStatus", PaymentStatus)
      define_attribute_mapping(:response_code, "ResponseCode")
      define_attribute_mapping(:transaction_id, "TransactionID")
    end
  end
end
