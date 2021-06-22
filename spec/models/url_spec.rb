# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      skip 'add test'
    end

    it 'ensures that short url is always created' do
      expect{Url.create!(original_url: "https://example.com", created_at: Time.now)}.not_to raise_error(ActiveRecord::NotNullViolation)
    end

    # add more tests
  end
end
