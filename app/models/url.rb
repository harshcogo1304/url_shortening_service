class Url < ApplicationRecord
  CHARACTERS = [*'a'..'z', *'A'..'Z', *'0'..'9'].freeze

  def generate_short_url(length)
    Array.new(length) { CHARACTERS.sample }.join
  end
end