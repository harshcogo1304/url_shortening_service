class Url < ApplicationRecord
  CHARACTERS = [*'a'..'z', *'A'..'Z', *'0'..'9'].freeze

  validates_presence_of :short_url, :long_url

  def generate_short_url(length)
    Array.new(length) { CHARACTERS.sample }.join
  end
end
