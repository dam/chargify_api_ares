module Chargify
  class Referral < Base
    include ResponseHelper

    def self.validate(referral_code)
      raise ArgumentError, 'referral_code is a required argument' if referral_code.blank?

      path = "/referral_codes/validate.xml?code=#{referral_code}"
      response = connection.get(path, headers)
      response.is_a?(Net::HTTPSuccess)
    rescue ActiveResource::ResourceNotFound
      false
    end
  end
end
