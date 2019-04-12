# frozen_string_literal: true

class Number
  def self.usd(amount)
    figure = amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    "$#{figure} US"
  end
end
