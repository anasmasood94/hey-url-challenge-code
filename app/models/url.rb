# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  has_many :clicks
  before_create :generate_short_url

  def log_click
    self.update(clicks_count: self.clicks_count + 1)
  end

  private
    def generate_short_url
      return if self.short_url
      self.short_url = Faker::Name.unique.first_name
    end
end
