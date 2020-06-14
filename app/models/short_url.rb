# frozen_string_literal: true

require 'base62-rb'

class ShortUrl < ApplicationRecord
  self.primary_key = 'id'
  validates_with UrlValidator


  before_save do
    self.created_at ||= Time.now
    self.modified_at = Time.now
  end

  after_initialize do
    self.id ||= ShortUrl.count + 1
    self.short_url ||= Base62.encode(self.id + Rails.application.config.encode_padding)
    unless self.full_url[/\Ahttp:\/\//] || self.full_url[/\Ahttps:\/\//]
      self.full_url = "http://#{self.full_url}"
    end
    self.valid?
  end

  def self.load_by_short_url(short_url:)
    where(short_url: short_url).first!
  end
end
