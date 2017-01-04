require 'spec_helper'

describe Chargify::Referral, :fake_resource do
  context '.validate' do
    before do
      FakeWeb.register_uri(:get, "#{test_domain}/referral_codes/validate.json?code=foobar123", :body => 'hello')
      FakeWeb.register_uri(:get, "#{test_domain}/referral_codes/validate.json?code=fake", :status => ["404", "Not Found"])
    end

    it 'returns true if the referral_code is valid' do
      response = Chargify::Referral.validate('foobar123')
      response.should be_true
    end

    it 'returns false if the referral_code is invalid' do
      response = Chargify::Referral.validate('fake')
      response.should be_false
    end

    it 'treats the referral_code as a required parameter' do
      expect { Chargify::Referral.validate }.to raise_error(ArgumentError)
    end
  end
end
