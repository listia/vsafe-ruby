require "vsafe/response"

module VSafe
  module Responses
    class GetSessionTags < Response
      define_attribute_mapping(:org_id, "OrgID")
      define_attribute_mapping(:web_session_id, "WebSessionID")
    end
  end
end
