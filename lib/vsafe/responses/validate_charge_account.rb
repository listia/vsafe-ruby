require "vsafe/response"
require "vsafe/avs_result"
require "vsafe/auth_result"
require "vsafe/cvn_result"
require "vsafe/payment_status"

module VSafe
  module Responses
    class ValidateChargeAccount < Response
      define_attribute_mapping(:avs_result, "AVSResultCode", AvsResult)
      define_attribute_mapping(:auth_result, "AuthResultCode", AuthResult)
      define_attribute_mapping(:cvn_result, "CVNResultCode", CvnResult)
      define_attribute_mapping(:charge_permanent_token, "ChargePermanentToken")
      define_attribute_mapping(:payment_acquirer_name, "PaymentAcquirerName")
      define_attribute_mapping(:payment_id, "PaymentID")
      define_attribute_mapping(:payment_status, "PaymentStatus", PaymentStatus)
    end
  end
end
