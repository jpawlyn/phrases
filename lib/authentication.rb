module Authentication
  VALID_TOKENS = %w(12345 6789)
  def self.authenticate(token)
    VALID_TOKENS.include? token
  end
end