class User < ApplicationRecord
  acts_as_authentic do |c|
    c.ignore_blank_passwords = false
    c.session_ids = [:public]
    c.crypto_provider = Authlogic::CryptoProviders::SCrypt
  end

  def self.find_by_lowercase_login(login)
    find_by("lower(login) = ?", login.try(:downcase))
  end
end
