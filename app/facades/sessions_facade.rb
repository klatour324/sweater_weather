class SessionsFacade
  def self.get_authenticated_user(params)
    return 'invalid parameters' if !valid_params.all? { |key| params.has_key?(key) }
    user = User.find_by(email: params[:email].downcase)
    user if user && user.authenticate(params[:password])
  end

  def self.valid_params
    [:email, :password]
  end
end
