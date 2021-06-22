# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      expect{Click.create!(browser: "Chrome", platform: "mac")}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates browser is not null' do
      url = FactoryBot.create(:url)
      expect{Click.create!(url_id: url.id, platform: "mac")}.to raise_error(ActiveRecord::NotNullViolation)
    end

    it 'validates platform is not null' do
      url = FactoryBot.create(:url)
      expect{Click.create!(url_id: url.id, browser: "Chrome")}.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
